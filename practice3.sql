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



# 3.テーブルの紐づけ: 外部キーと主キーを使う。外部キーで他のテーブルにある主キーを指定することで、テーブル同士を紐付けることができる
-- (例)主キー: countriesテーブルのidカラムの「1番」⇄　外部キー: playersテーブルのcountry_idカラムの「1番」
SELECT SUM(goals), country_id
FROM players
GROUP BY country_id # ←「GROUP BY カラム名」で「カラム名をグループ分けできる(グループごとに分類する事が可能)」※カラム名はSELECTで定義した関数以外のカラム名
-- ↑国ごとの合計得点数、国ごとのidを知りたい



# 4.テーブルの結合とは: 紐付いたテーブル同士をJOINを使うことで結合させることができる。結合したテーブルは1つのテーブルと同じようにデータを取得することができる。
-- JOINとは: 複数のテーブルを1つに結合したいときに使う。「ON」で条件を指定して「FROMテーブル」に「JOINで指定したテーブル」を結合する
-- 結合条件「ON」は「ON テーブル名(FROM).カラム名(外部キー) = テーブル名(JOIN).カラム名(主キー)」で指定する
SELECT *
FROM players
JOIN countries
ON players.country_id = countries.id;
-- ↑playersテーブルにcountriesテーブルを結合させる(条件は、playersテーブルのcountry_idカラムとcountriesテーブルのidカラムを結合)



# 5.複数テーブルでのカラム名の指定
-- 複数のテーブルに同じカラム名が存在するときは、「SELECT」で「テーブル名.カラム名」で指定する必要がある。※「テーブル名.カラム名」を用いたカラム指定は「WHERE内」でも使える
-- ※実行順序: テーブルの指定(FROM)→結合(ON・JOIN)→取得条件(WHERE)→グループ化(GROUP BY)→関数(COUNT/SUM/AVG/MIN)→HEAVING→検索(SELECT・DISTINCT)→順序(ORDER BY)→LIMIT
SELECT players.name,countries.name
FROM players
JOIN countries
ON players.country_id = countries.id
-- ↑playersの名前とcountriesの名前が知りたい(カラムが同名なので指定)、playersテーブルにcountriesテーブルを結合させる(条件は、playersテーブルのcountry_idカラムとcountriesテーブルのidカラムを結合)

SELECT countries.name, SUM(goals)
FROM players
JOIN countries
ON players.country_id = countries.id
GROUP BY countries.name;
-- ↑国ごとの国名と国ごとの得点数を知りたい(同名カラムの指定)、playersテーブルにcountriesテーブルを結合させる(条件は、playersテーブルのcountry_idカラムとcountriesテーブルのidカラムを結合)、国の名前でグループ分け



# 6.外部キーに「NULL」を含んだ場合の「JOIN」の実行結果: 外部キーがNULLのレコードは、実行結果に表示されない(NULLのレコードは取得しない飛ばす)
SELECT *
FROM players
JOIN teams
ON players.previous_team_id = teams.id;
-- ↑全てのカラムを知りたい、playersテーブルにteamsテーブルを結合させる(条件は、playersテーブルのprevious_team_idカラムとteamsテーブルのidカラムを結合)

SELECT players.name AS "選手名", teams.name AS "前年所属していたチーム"
FROM players
JOIN teams
ON players.previous_team_id = teams.id;
-- ↑選手名と前年所属していたチーム名が知りたい(同名カラムの指定かつカラム名の変更)、playersテーブルにteamsテーブルを結合させる(条件は、playersテーブルのprevious_team_idカラムとteamsテーブルのidカラムを結合)



# 7.LEFT JOINとは:「JOIN」では外部キーがNULLのレコードは取得しなかったが、「LEFT JOIN」を使用することでNULLのレコードも含めて全て取得する
SELECT *
FROM players
LEFT JOIN teams
ON players.previous_team_id = teams.id;
-- ↑全てのカラムを知りたい、playersテーブルにteamsテーブルを結合させる「NULLのレコードも取得」(条件は、playersテーブルのprevious_team_idカラムとteamsテーブルのidカラムを結合)

SELECT players.name AS "選手名", teams.name AS "前年所属していたチーム"
FROM players
LEFT JOIN teams
ON players.previous_team_id = teams.id;
-- ↑選手名と前年所属していたチーム名が知りたい(同名カラムの指定かつカラム名の変更)、playersテーブルにteamsテーブルを結合させる「NULLのレコードも取得」(条件は、playersテーブルのprevious_team_idカラムとteamsテーブルのidカラムを結合)



# 8.複数(2つ以上)のテーブルの結合: JOINは1つのクエリで、複数回使用でき複数のテーブルを結合できる
SELECT *
FROM players
JOIN countries
ON players.country_id = countries.id
LEFT JOIN teams
ON players.previous_team_id = teams.id;
-- ↑playersテーブルにcountriesテーブルとteamsテーブル(NULL含む)の結合(条件は省略)



-- ↓総合演習↓
SELECT name AS "選手名", height AS "身長"
FROM players
WHERE height > (
  SELECT AVG(height)
  FROM players
);
-- ↑サブクエリでは平均身長がしたい。クエリでは選手名と身長が知りたい(ASでカラム名変更)、どんな?「平均身長よりも高い選手名と身長」

SELECT *
FROM players
JOIN countries
ON players.country_id = countries.id
WHERE countries.name = "日本"
AND players.height >= 180;
-- ↑playersテーブルにcountriesテーブルを結合(条件は省略)、全てのカラムが知りたい。その中でも国の名前が日本と選手の身長が180以上の人

SELECT countries.name AS "国名", AVG(goals) AS "平均得点"
FROM players
JOIN countries
ON players.country_id = countries.id
GROUP BY countries.name;
-- ↑playersテーブルにcountriesテーブルを結合(条件は省略)、国ごとの名前(playersテーブルにも同名カラムがあるので何のカラムか定義)と国ごとの平均得点が知りたい(ASでカラム名変更)、国の名前でグループ分け