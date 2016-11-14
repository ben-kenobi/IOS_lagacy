-- 创建个人表

CREATE TABLE IF NOT EXISTS "T_Person" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "age" INTEGER,
    "height" REAL
);

-- 创建图书表

CREATE TABLE IF NOT EXISTS "T_Book" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "bookName" TEXT
);
