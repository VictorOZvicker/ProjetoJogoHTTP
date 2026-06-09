from fastapi import FastAPI, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text
from database import AsyncSessionLocal, engine
from pydantic import BaseModel

app = FastAPI()

@app.on_event("startup")
async def startup():
    async with engine.begin() as conn:
        await conn.execute(text("""
            CREATE TABLE IF NOT EXISTS scores (
                id         SERIAL PRIMARY KEY,
                player     VARCHAR(100) NOT NULL,
                score      INTEGER NOT NULL,
                created_at TIMESTAMPTZ DEFAULT NOW()
            )
        """))


class ScoreIn(BaseModel):
    player: str
    score: int

async def get_db():
    async with AsyncSessionLocal() as session:
        yield session

@app.post("/scores")
async def save_score(data: ScoreIn, db: AsyncSession = Depends(get_db)):
    await db.execute(
        text("INSERT INTO scores (player, score) VALUES (:player, :score)"),
        {"player": data.player, "score": data.score}
    )
    await db.commit()
    return {"status": "ok"}

@app.get("/scores/top")
async def top_scores(db: AsyncSession = Depends(get_db)):
    result = await db.execute(
        text("SELECT player, score FROM scores ORDER BY score DESC LIMIT 100")
    )
    return result.mappings().all()