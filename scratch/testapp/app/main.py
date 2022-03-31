import os

import uvicorn
from typing import Optional
from fastapi import FastAPI, Request, HTTPException
from fastapi.staticfiles import StaticFiles
from starlette.responses import FileResponse 

app = FastAPI()


@app.get("/tailwind/")
async def read_index():
    return FileResponse('play-tailwind-main/index.html')


app.mount("/tailwind/", StaticFiles(directory="play-tailwind-main"), name="static")


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/hello")
def read_root():
    return {"Hello": "World"}


ACCESS_TOKEN_KEY = os.environ['ACCESS_TOKEN_KEY']
ACCESS_TOKEN_VALUE = os.environ['ACCESS_TOKEN_VALUE']


@app.get("/auth")
async def auth(request: Request):
    if (ACCESS_TOKEN_KEY in request.headers) and (request.headers[ACCESS_TOKEN_KEY] == ACCESS_TOKEN_VALUE):
        return "okay"
    else:
        raise HTTPException(status_code=401, detail="You are not logged in.")


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Optional[str] = None):
    return {"item_id": item_id, "q": q}


if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)


