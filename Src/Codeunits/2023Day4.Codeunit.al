codeunit 52003 "2023 Day 4 AOC"
{
    TableNo = "Puzzle AOC";

    trigger OnRun()
    var
        SourceInStream: InStream;
        Score: Integer;
        LineElements: List of [Text];
        Line: Text;
    begin
        Rec."Puzzle Imput".CreateInStream(SourceInStream);
        //Create list of subsets
        while not SourceInStream.EOS do begin
            SourceInStream.ReadText(Line);
            Line := Line.Trim();
            LineElements := Line.Trim().Split(':', '|');
            Score += GetScore(LineElements);
        end;

        Message(Format(Score));
    end;

    local procedure GetScore(LineElements: List of [Text]): Integer;
    var
        i: Integer;
        Cards: List of [Text];
        Element: Text;
        CardNumber: Text;
        WinningNUmbers: List of [Text];
        NumbersYouHave: List of [Text];
        CardScore: Integer;
    begin
        //Get Game Number from 1st element of Line
        LineElements.Get(1, CardNumber);
        Cards := CardNumber.Trim().Split(' ');
        RemoveEmptyElements(Cards);
        Cards.Get(2, CardNumber);

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
        for i := 1 to NumbersYouHave.Count do
            if WinningNUmbers.Contains(NumbersYouHave.Get(i)) then
                if CardScore in [0, 1] then
                    CardScore += 1
                else
                    CardScore := CardScore * 2;

        exit(CardScore);
    end;

    local procedure RemoveEmptyElements(var ListToClear: List of [Text])
    begin
        while ListToClear.Contains('') do
            ListToClear.Remove('');
    end;
}