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