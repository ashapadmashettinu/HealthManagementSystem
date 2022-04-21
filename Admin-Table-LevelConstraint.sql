create or alter function ufAdminCount ()
returns int
begin
   declare @count int;
   select  @count = count(*)
      from AdminInformation
   return @count;
end

alter table AdminInformation add CONSTRAINT Check_Admin_Count_100 CHECK (dbo.ufAdminCount 
() <= 100);