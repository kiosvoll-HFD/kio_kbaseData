CREATE FUNCTION [dbo].[Split2](@input AS Varchar(max), @splittekst varchar(100))  
RETURNS  
      @Result TABLE(Value varchar(2000))  
AS  
BEGIN  
      DECLARE @str VARCHAR(2000)  
      DECLARE @ind Int  

	  select @input = replace(@input,char(13),'')
	  select @input = replace(@input,char(10),'')
	  select @input = replace(@input,char(9),'')

      IF(@input is not null)  
      BEGIN  
            SET @ind = CharIndex(@splittekst,@input)  
            WHILE @ind > 0  
            BEGIN  
                  SET @str = SUBSTRING(@input,1,@ind-1)  
                  SET @input = SUBSTRING(@input,@ind+1,LEN(@input)-@ind)  
                  INSERT INTO @Result values (@str)  
                  SET @ind = CharIndex(@splittekst,@input)  
            END  
            SET @str = @input  
            INSERT INTO @Result values (@str)  
      END  
      RETURN  
END 

