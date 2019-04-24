
-- test
--- select dbo.[HenteUtStringdelNr_basertpaaSkilleteikn]('Kapittel I::(A00-A09)::A01::A01.4','::',1)
--- select dbo.[HenteUtStringdelNr_basertpaaSkilleteikn]('Kapittel I::(A00-A09)::A01::A01.4','::',2)
--- select dbo.[HenteUtStringdelNr_basertpaaSkilleteikn]('Kapittel I::(A00-A09)::A01::A01.4','::',3)
--- select dbo.[HenteUtStringdelNr_basertpaaSkilleteikn]('Kapittel I::(A00-A09)::A01::A01.4','::',4)

--- select dbo.[HenteUtStringdelNr_basertpaaSkilleteikn]('Kapittel I,(A00-A09),A01,A01.4',',',1)
--- select dbo.[HenteUtStringdelNr_basertpaaSkilleteikn]('Kapittel I,(A00-A09),A01,A01.4',',',2)
--- select dbo.[HenteUtStringdelNr_basertpaaSkilleteikn]('Kapittel I,(A00-A09),A01,A01.4',',',3)
--- select dbo.[HenteUtStringdelNr_basertpaaSkilleteikn]('Kapittel I,(A00-A09),A01,A01.4',',',4)




CREATE function [dbo].[HenteUtStringdelNr_basertpaaSkilleteikn] (@tekst varchar(300), @skilleteikn varchar(50),@StringDelnr int)
returns varchar(300)
as 
begin 
/*

declare @tekst  varchar(300) = 'Kapittel I::(A00-A09)::A01::A01.4'
declare @StringDelnr int = 4
declare @skilleteikn varchar(50) = '::'

--*/

declare @startSkilleposisjon  int = 1 
declare @StringPeikarLengde int = 300 
declare @NesteSkillePosisjon  int 
declare @teller int = 0   -- teller kor mange loopar ein har køyrt i teksten
declare @StringPeikar varchar(100)
declare @StringRest varchar(300)
declare @sumStringkonkat int = 0 
declare @sumStringkonkat_forrige int = -1 


select @stringRest = @tekst
-- blankar ut "jobbe stringen" dersom posisjonen er for høg i forhold til skilleteikn
select @stringRest = case when (len(@stringRest) -  len(replace(@stringRest,@skilleteikn,''))) / len( @skilleteikn ) + 1 <  @StringDelnr then '' else @stringRest end




while @teller < @StringDelnr 
				and isnull(@startSkilleposisjon ,0) <> 0 
				and @sumStringkonkat > @sumStringkonkat_forrige
begin 
	select @teller = @teller + 1 
	select @stringRest = substring(@stringRest,@startSkilleposisjon,300)
	select @NesteSkillePosisjon = charindex(@skilleteikn,@StringRest) 
	select @StringPeikarLengde = case when @NesteSkillePosisjon <> 0 then @NesteSkillePosisjon - 1  end
	select @StringPeikar = substring(@stringRest,1,@StringPeikarLengde) 
	select @startSkilleposisjon = case when @NesteSkillePosisjon = 0  then 0 else  @NesteSkillePosisjon + len(@skilleteikn) end
	select @sumStringkonkat_forrige = @sumStringkonkat
	select @sumStringkonkat = @sumStringkonkat + len(@StringPeikar) 
	
end 

select @StringPeikar = ISNULL(@StringPeikar,@stringRest)

--select  '@teller     ' + converT(varchar,@teller )
--select  '@startSkilleposisjon    '  + converT(varchar,@startSkilleposisjon )
--select  '@NesteSkillePosisjon    ' + converT(varchar,@NesteSkillePosisjon )
--select  '@StringPeikarLengde    ' + converT(varchar,@StringPeikarLengde )
--select  '@tekst     ' + @tekst
--select  '@StringPeikar     ' + @StringPeikar
--select  '@StringRest          ' + converT(varchar,@StringRest )

return @StringPeikar

end 

GO


