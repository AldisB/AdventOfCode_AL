page 52000 "Adventure of Code AOC"
{
    ApplicationArea = All;
    Caption = 'Adventure of Code';
    PageType = List;
    SourceTable = "Puzzle AOC";
    UsageCategory = Tasks;
    SourceTableView = order(descending);
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year field.';
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Day field.';
                }
                field(URL; Rec.URL)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the URL to puzzle text and file field.';
                }
                field("Answer Codeunit"; Rec."Answer Codeunit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Answer Codeunit field.';
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
            action(RemovePuzleInput)
            {
                ApplicationArea = All;
                Caption = 'Remove Puzzle Input';
                Image = Delete;
                ToolTip = 'Remove Puzzle Input';

                trigger OnAction()
                var
                    ImportWaterReadings: Codeunit "Adventure of Code Mgt. AOC";
                begin
                    ImportWaterReadings.RemovePuzzleInput(Rec);
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