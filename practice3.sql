-- DISTINCTとは: SELECTで取得するカラムに使用することで、そのカラム内の重複するデータを省くことができる「SELECT DISTINCT (カラム名)」
SELECT DISTINCT(character_name)
FROM purchases;
-- ↑重複するデータを除いたcharacter_nameカラムのデータを取得



-- 四則演算: SQLでも四則演算が可能。SELECTで取得するカラムに使用することで計算後のデータを取得できる
SELECT name, price, price * 1.08
FROM purchases;
-- ↑name, priceカラムの他に、消費税を8%含んだpriceカラムのデータを取得



-- 関数SUM: SQLでカラム内の数値の「合計」を計算する場合は「SUM」を用いる。
-- SELECTで取得するカラムに用いることで、集計結果を取得することができる。「SELECT SUM(カラム名)」
SELECT SUM(price)
FROM purchases;
-- ↑priceカラムの合計値を取得

SELECT SUM(price)
FROM purchases
WHERE character_name = "にんじゃわんこ"
;
-- ↑合計金額が知りたい、誰の?「にんじゃわんこ」の



-- 関数AVG: SQLでカラム内の数値の「平均」を計算する場合は「AVG」を用いる。
-- SELECTで取得するカラムに用いることで、平均結果を取得することができる。「SELECT AVG(カラム名)」
SELECT AVG(price)
FROM purchases;
-- ↑priceカラムの平均値を取得

SELECT AVG(price)
FROM purchases
WHERE character_name = "にんじゃわんこ"
;
-- ↑平均金額が知りたい、誰の?「にんじゃわんこ」の



-- 関数COUNT: 指定したカラムのデータの合計数を取得する。「SELECT COUNT(カラム名)」
-- ※nullになっているデータは除外される。nullの数も含めてデータの合計数を取得したい場合はカラムを「*」にする(特定のカラムのデータの数ではなく、レコードの数を取得する)
SELECT COUNT(name)
FROM purchases;
-- ↑nameカラムのデータの数を取得

SELECT COUNT(*)
FROM purchases;
-- ↑nullを含めたデータの数を取得(レコードの数を取得)

SELECT COUNT(*)
FROM purchases
WHERE character_name = "にんじゃわんこ"
;
-- ↑nullを含めたデータの数(レコードの数)が知りたい、誰の?「にんじゃわんこ」の



-- 関数MAX/MIN: SQLでカラム内の「最大のデータ」を知りたい時は「MAX」、「最小のデータ」を知りたい時は「MIN」を用いる。
-- SELECTで取得するカラムに用いることで、最大/最小のデータを取得することができる。「SELECT MAX/MIN(カラム名)」
SELECT MAX(price)
FROM purchases;
-- ↑priceカラムの最大値を取得

SELECT MIN(price)
FROM purchases;
-- ↑priceカラムの最小値を取得

SELECT MAX(price)
FROM purchases
WHERE character_name = "にんじゃわんこ"
;
-- ↑金額の最大値を知りたい、誰の?「にんじゃわんこ」の



-- GROUP BYとは: データをグループ化することができる。「GROUP BY カラム名」とすることで、指定したカラム内で同一のデータを持つレコード同士が同じグループとなる
-- ※GROUP BYを用いる場合、SELECTで使えるのはGROUP BYに指定している「カラム名」と「集計関数」のみ
SELECT SUM(price), purchased_at
FROM purchases
GROUP BY purchased_at
;
-- ↑日付(purchased_at)ごとの金額の合計値(SUM(price))を取得(日付でグループ分け)

SELECT COUNT(price), purchased_at
FROM purchases
GROUP BY purchased_at
;
-- ↑日付(purchased_at)ごとのお金を使った数(COUNT(price))を取得(日付でグループ分け)



-- 複数カラムを指定したGROUP BY:「GROUP BY カラム名1,カラム名2」カラム名同士をコンマ(,)で繋げる
SELECT SUM(price), purchased_at, character_name
FROM purchases
GROUP BY purchased_at, character_name
;
-- ↑キャラクター(character_name)が日付(purchased_at)ごとに使用した金額の合計値(SUM(price))を取得(日付とキャラクター名でグループ分け)

SELECT COUNT(*), purchased_at, character_name
FROM purchases
GROUP BY purchased_at, character_name
;
-- ↑キャラクター(character_name)が日付(purchased_at)ごとにお金を使った回数(COUNT(*))を取得(日付とキャラクター名でグループ分け)



-- ↓WHEREを併用したGROUP BY
SELECT SUM(price), purchased_at
FROM purchases
WHERE character_name = "にんじゃわんこ"
GROUP BY purchased_at
;
-- ↑にんじゃわんこが日付ごとに使用した金額の合計値を取得(WEHREで条件を指定し、日付でグループ分け)

SELECT SUM(price), purchased_at, character_name
FROM purchases
WHERE category = "食費"
GROUP BY purchased_at, character_name
;
-- ↑食費に置けるキャラクターが日付ごとにかかった金額の合計値を取得(WEHREで何に使用したか条件を指定し、日付とキャラクター名でグループ分け)



-- HAVINGとは: GROUP BYでグループ化したデータから、更に特定のグループのみを取得したい時に用いる「GROUP BY カラム名 HAVING 条件」
-- WHEREは「グループ化される前」のテーブル全体を検索対象とするのに対し、HAVINGは「GROUP BYによってグループ化された」データを検索対象とする
-- ※HAVINGの条件文で使うカラムは必ずグループ化されたテーブルのカラムを使う!
SELECT SUM(price), purchased_at
FROM purchases
GROUP BY purchased_at
HAVING SUM(price) > 2000
;
-- ↑日付ごとに使用した金額の合計の内、2000を超えるデータのみを取得(日付でグループ分けをし、HAVINGで金額の条件を指定)

SELECT SUM(price), purchased_at, character_name
FROM purchases
GROUP BY purchased_at, character_name
HAVING SUM(price) > 3000
;
-- ↑キャラクターが日付ごとに使用した金額の合計の内、3000を超えるデータのみを取得(日付でグループ分けをし、HAVINGで金額の条件を指定)