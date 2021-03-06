USE [SinavSistemi]
GO
/****** Object:  StoredProcedure [dbo].[İlkSinavYap]    Script Date: 15.12.2019 21:02:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[İlkSinavYap]
AS
-- Değişken Tanımlama
DECLARE @i int
SET @i = 1
DECLARE @konusayi int
SET @konusayi = (SELECT COUNT(*) FROM tbl_Konu)
PRINT @konusayi
--Eski verilerin silinmesi
DELETE FROM tbl_Sorulan

-- Her konudan bir tane getirme
WHILE(@i<=@konusayi)
BEGIN
INSERT INTO tbl_Sorulan(soruID,soruOnBilgi,soruIcerik,soruA,soruB,soruC,soruD,soruDogruCevap,soruKonuID)
SELECT TOP(4) soruID,soruOnBilgi,soruIcerik,soruA,soruB,soruC,soruD,soruDogruCevap,soruKonuID FROM tbl_Soru S JOIN tbl_Konu K 
ON S.soruKonuID = K.konuID
WHERE K.konuID = @i ORDER BY NEWID()

SET @i = @i +1
END