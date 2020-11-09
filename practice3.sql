# 1.サブクエリとは: クエリの中に他のクエリを入れて「2つ以上のクエリを1つにまとめる」ことができる
-- ①大元のクエリの最後に「( )で囲むことで、サブクエリを使用できる」※()内にセミコロン（;）は不要
-- ②サブクエリが実行された後、外側にあるクエリが実行される
SELECT name
FROM players
WHERE goals > (
  SELECT goals
  FROM players
  WHERE name = "ウィル"
);
-- ↑得点数を知りたい、誰の?「ウィルの」。名前を知りたい、どんな?「ウィルよりも得点数が多い人の」



SELECT name,goals
FROM players
WHERE goals > (
  SELECT AVG(goals) # ←AVG():平均
  FROM players
);
-- ↑平均得点数を知りたい。名前と得点数を知りたい、どんな?「平均得点数よりも得点数が多い人の名前と得点」



# 2.ASとは: カラム名などに別名を定義することができる。「カラム名 AS "名前"」で、カラム名に定義する名前を指定する。
SELECT name AS "身長180cm以上の選手"
FROM players
WHERE height >= 180;
-- ↑名前を知りたい。誰の?「身長が180以上の人の」

SELECT SUM(goals) AS "チームの合計得点" # ←SUM():合計
FROM players;
-- ↑合計得点数が知りたい