codeunit 52002 "2023 Day 3 AOC"
{
    TableNo = "Puzzle AOC";

    var
        Lines: List of [Text];
        SetofLines: List of [List of [Text]];
        StarCoordinate: Dictionary of [Text, Integer];
        sumofpartnumbers: integer;

    trigger OnRun()
    var
        SourceInStream: InStream;
        i, j : Integer;
        Line: Text;
        number: Dictionary of [Text, Integer];
    begin
        Rec."Puzzle Imput".CreateInStream(SourceInStream);
        //Split line by chars and add to list - create matrix of chars 140x140
        while not SourceInStream.EOS do begin
            SourceInStream.ReadText(Line);
            for i := 1 to StrLen(Line) do
                Lines.Add(Line[i]);
            SetofLines.Add(Lines);
            Clear(Lines)
        end;

        //serch for numbers and check if they are part numbers
        for i := 1 to SetofLines.Count() do begin
            Lines := SetofLines.Get(i);
            for j := 1 to Lines.Count() do
                if isNumber(Lines.Get(j)) then begin
                    number.Add('FromX', j);
                    number.Add('Number', getNumber(j, Lines.Get(j)));
                    number.Add('ToX', j);

                    //Check if number is part number
                    if isPartNumber(i, number) then begin
                        //Part I
                        //sumofpartnumbers += number.Get('Number');

                    end;
                    clear(number);
                    Lines := SetofLines.Get(i);
                end;
        end;
        Message(format(sumofpartnumbers));
    end;

    local procedure isPartNumber(y: integer; number: Dictionary of [Text, Integer]): Boolean
    var
        i: integer;
    begin
        //check if any symbol around number is not dot
        if number.Get('FromX') > 1 then
            if not isDot(number.Get('FromX') - 1, y, number.Get('Number')) then
                exit(true);

        if number.Get('ToX') < Lines.Count then
            if not isDot(number.Get('ToX') + 1, y, number.Get('Number')) then
                exit(true);

        //if number is first in line
        if number.Get('FromX') = 1 then
            number.Set('FromX', 2);

        //if number is last in line
        if number.Get('ToX') = Lines.Count then
            number.Set('ToX', Lines.Count - 1);

        if y > 1 then
            for i := number.Get('FromX') - 1 to number.Get('ToX') + 1 do
                if not isDot(i, y - 1, number.Get('Number')) then
                    exit(true);

        if (y < SetofLines.Count) then
            for i := number.Get('FromX') - 1 to number.Get('ToX') + 1 do
                if not isDot(i, y + 1, number.Get('Number')) then
                    exit(true);

        exit(false);
    end;

    // Part I local procedure isDot(x: Integer; y: integer): Boolean
    local procedure isDot(x: Integer; y: integer; CurrentNumber: Integer): Boolean
    var
        secondcog: integer; //Part II
    begin
        Lines := SetofLines.Get(y);
        //Part I
        // if Lines.Get(x) = '.' then
        //     exit(true);

        // exit(false);

        //Part II
        if Lines.Get(x) = '*' then begin
            if StarCoordinate.ContainsKey(format(x) + ';' + Format(y)) then begin
                StarCoordinate.Get(format(x) + ';' + Format(y), secondcog);
                sumofpartnumbers += (secondcog * CurrentNumber);
            end else
                StarCoordinate.Add(format(x) + ';' + Format(y), CurrentNumber);
            exit(false)
        end;

        exit(true);
    end;

    local procedure getNumber(var j: Integer; currentnumber: Text): Integer
    var
        currentnumberInt: Integer;
        i: integer;
    begin
        for i := j + 1 to Lines.Count do
            if isNumber(Lines.Get(i)) then begin
                currentnumber += Lines.Get(i);
                j += 1;
            end else
                i := Lines.Count;

        Evaluate(currentnumberInt, currentnumber);
        exit(currentnumberInt);
    end;

    local procedure isNumber(symbol: text[1]): Boolean
    begin
        if symbol in ['0' .. '9'] then
            exit(true);

        exit(false);
    end;
}