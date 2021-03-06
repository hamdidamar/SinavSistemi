USE [SinavSistemi]
GO
/****** Object:  StoredProcedure [dbo].[basariOraniHesapla]    Script Date: 15.12.2019 21:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[basariOraniHesapla] as

delete from tbl_Basari

declare @dogru decimal
declare @toplam decimal
declare @oran decimal
declare @konusayisi int
declare @ogrenci int = 1
declare @i int = 1
declare @j int = 1
select @konusayisi = (select count(*) from tbl_Konu)

declare @ogrenciSayisi int = (select count(distinct cevapOgrenciID) from tbl_Cevap)
print @ogrenciSayisi

while (@ogrenci<=@ogrenciSayisi)
begin
print @ogrenci
declare @sinav int = (select count(distinct cevapsinavID) from tbl_Cevap where cevapOgrenciID = @ogrenci)
print @sinav
set @j = 1
while (@j<=@sinav)
begin
set @i =1
while (@i<=@konusayisi)
begin
	
	select @dogru = (SELECT COUNT(*) FROM tbl_Cevap where cevapKonuID = @i and dogruYanlisKontrol = 1 AND cevapOgrenciID = @ogrenci and cevapSinavID = @j )
	select @toplam =  (select count(*) from tbl_Cevap where cevapKonuID = @i AND cevapOgrenciID = @ogrenci and cevapSinavID = @j)
	
	select @oran = (@dogru/@toplam)*100
	insert into tbl_Basari(ogrenciID,konuID,basariOrani,sinavID) values(@ogrenci,@i,@oran,@j)
	select @i +=1
end
	select @j +=1
end
select @ogrenci +=1;
end
--exec basariOraniHesapla