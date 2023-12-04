codeunit 52003 "2023 Day 4 AOC"
{
    TableNo = "Puzzle AOC";

    trigger OnRun()
    var
        SourceInStream: InStream;
        Score: Integer;
        i: integer;
        LineElements: List of [Text];
        Line: Text;
        AllLines: List of [List of [Text]];
    begin
        Rec."Puzzle Imput".CreateInStream(SourceInStream);
        //Create list of subsets
        while not SourceInStream.EOS do begin
            SourceInStream.ReadText(Line);
            Line := Line.Trim();
            LineElements := Line.Trim().Split(':', '|');
            AllLines.Add(LineElements);
        end;

        for i := 1 to AllLines.Count do begin
            LineElements := AllLines.Get(i);

            Score += GetScore(AllLines, i);
        end;

        //Add original cards
        Score += AllLines.Count;

        Message(Format(Score));
    end;

    local procedure GetScore(AllLines: List of [List of [Text]]; i: integer): Integer;
    var
        j: Integer;
        Element: Text;
        WinningNUmbers: List of [Text];
        NumbersYouHave: List of [Text];
        LineElements: List of [Text];
        CardScore: Integer;
    begin
        LineElements := AllLines.Get(i);
        //Winning numbers
        LineElements.Get(2, Element);
        WinningNumbers := Element.Trim().Split(' ');
        RemoveEmptyElements(WinningNumbers);

        //Numbers You Have
        LineElements.Get(3, Element);
        NumbersYouHave := Element.Trim().Split(' ');
        RemoveEmptyElements(NumbersYouHave);

        //Calc winning numbers
        CardScore := 0;
        for j := 1 to NumbersYouHave.Count do
            if WinningNUmbers.Contains(NumbersYouHave.Get(j)) then begin
                CardScore += 1;
                i += 1;
                CardScore += GetScore(AllLines, i);
            end;

        exit(CardScore);
    end;

    local procedure RemoveEmptyElements(var ListToClear: List of [Text])
    begin
        while ListToClear.Contains('') do
            ListToClear.Remove('');
    end;
}