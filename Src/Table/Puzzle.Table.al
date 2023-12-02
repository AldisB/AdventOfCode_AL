table 52000 "Puzzle AOC"
{
    Caption = 'Puzzle';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = ToBeClassified;
        }
        field(2; Day; Integer)
        {
            Caption = 'Day';
            DataClassification = ToBeClassified;
        }
        field(3; URL; Text[1024])
        {
            Caption = 'URL to puzzle text and file';
            ExtendedDatatype = URL;
        }
        field(4; "Answer Codeunit"; Integer)
        {
            Caption = 'Answer Codeunit';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Codeunit));
        }
        field(5; "Puzzle Imput"; Blob)
        {
            Caption = 'Puzzle Imput';
        }
    }

    keys
    {
        key(PK; Year, Day)
        {
            Clustered = true;
        }
    }
}