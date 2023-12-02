codeunit 52001 "2023 Day 2 AOC"
{
    TableNo = "Puzzle AOC";

    var
        Limit: Dictionary of [Text, Integer];

    trigger OnRun()
    var
        SourceInStream: InStream;
        PossibleGames: Integer;
        Line: Text;
        LineElements: List of [Text];
    begin
        InitLimit();
        Rec."Puzzle Imput".CreateInStream(SourceInStream);
        //Create list of subsets
        while not SourceInStream.EOS do begin
            SourceInStream.ReadText(Line);
            Line := Line.Trim();
            LineElements := Line.Trim().Split(':', ';');
            PossibleGames += CheckLine(LineElements);
        end;

        Message(format(PossibleGames));
    end;

    local procedure CheckLine(LineElements: List of [Text]): Integer;
    var
        GameNumbers: List of [Text];
        GameNumber: Text;
        Element: Text;
        i: Integer;
        CurrentGame: Dictionary of [Text, Integer];
        CurrentGameIndex: Text;
        CurrentGameValue: Integer;
        OneSet: List of [Text];
        Cube: List of [Text];
        CubeValue: Integer;
        MinimumSet: Dictionary of [Text, Integer];
    begin
        //Get Game Number from 1st element of Line
        LineElements.Get(1, GameNumber);
        GameNumbers := GameNumber.Trim().Split(' ');
        GameNumbers.Get(2, GameNumber);

        //split by sets (3 green, 3 red, 4 blue)
        for i := 2 to LineElements.Count do begin
            OneSet := LineElements.Get(i).Trim().Split(',');

            //split and get saparate cube index and value and add to dictionary            
            foreach Element in OneSet do begin
                Cube := Element.Trim().Split();
                Evaluate(CubeValue, Cube.get(1));
                //Part I
                // if CurrentGame.ContainsKey(Cube.Get(2)) then
                //     //CurrentGame.Set(Cube.Get(2), CurrentGameValue + CubeValue)
                //     CurrentGame.Set(Cube.Get(2), CubeValue)
                // else
                //     CurrentGame.Add(Cube.Get(2), CubeValue);

                //Part II
                if MinimumSet.Get(Cube.Get(2), CurrentGameValue) then begin
                    if CurrentGameValue < CubeValue then
                        MinimumSet.Set(Cube.Get(2), CubeValue);
                end else
                    MinimumSet.Add(Cube.Get(2), CubeValue);
            end;
            //for part I
            //if not isPossible(CurrentGame) then
            //    exit(0);
        end;

        //for part I        
        //valuate(CubeValue, GameNumber);
        //exit(CubeValue);

        //for part II
        MinimumSet.Get('red', CurrentGameValue);
        CubeValue := CurrentGameValue;
        MinimumSet.Get('green', CurrentGameValue);
        CubeValue *= CurrentGameValue;
        MinimumSet.Get('blue', CurrentGameValue);
        CubeValue *= CurrentGameValue;
        exit(CubeValue);
    end;

    local procedure isPossible(CurrentGame: Dictionary of [Text, Integer]): Boolean
    begin
        if not isColorPossible(CurrentGame, 'red') then
            exit(false);
        if not isColorPossible(CurrentGame, 'green') then
            exit(false);
        if not isColorPossible(CurrentGame, 'blue') then
            exit(false);
        exit(true);
    end;

    local procedure isColorPossible(CurrentGame: Dictionary of [Text, Integer]; colro: Text): Boolean;
    begin
        if CurrentGame.ContainsKey(colro) then
            if CurrentGame.Get(colro) > Limit.Get(colro) then
                exit(false);

        exit(true);
    end;

    local procedure InitLimit()
    begin
        Limit.Add('red', 12);
        Limit.Add('green', 13);
        Limit.Add('blue', 14);
    end;
}