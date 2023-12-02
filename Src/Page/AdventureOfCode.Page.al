page 52000 "Adventure of Code AOC"
{
    ApplicationArea = All;
    Caption = 'Adventure of Code';
    PageType = List;
    SourceTable = "Puzzle AOC";
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                }
                field(URL; Rec.URL)
                {
                    ApplicationArea = All;
                }
                field("Answer Codeunit"; Rec."Answer Codeunit")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ImportPuzle)
            {
                ApplicationArea = All;
                Caption = 'Import Puzzle';
                Image = Questionaire;
                ToolTip = 'Import Puzzle';

                trigger OnAction()
                var
                    ImportWaterReadings: Codeunit "Adventure of Code Mgt. AOC";
                begin
                    ImportWaterReadings.SelectAndImportPuzzle(Rec);
                end;
            }
        }
        area(Promoted)
        {
            actionref(ImportPuzle_Promoted; ImportPuzle)
            {
            }
        }
    }
    trigger OnOpenPage()
    begin
    end;
}