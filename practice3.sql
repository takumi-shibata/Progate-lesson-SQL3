-- DISTINCTとは: SELECTで取得するカラムに使用することで、そのカラム内の重複するデータを省くことができる「SELECT DISTINCT (カラム名)」
SELECT DISTINCT(character_name)
FROM purchases;
-- ↑重複するデータを除いたcharacter_nameカラムのデータを取得



-- 四則演算: SQLでも四則演算が可能。SELECTで取得するカラムに使用することで計算後のデータを取得できる
SELECT name, price, price * 1.08
FROM purchases;
-- ↑name, priceカラムの他に、消費税を8%含んだpriceカラムのデータを取得