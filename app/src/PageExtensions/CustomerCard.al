pageextension 50000 "Customer Card_PTE" extends "Customer Card"
{
    // This code is created as an example and must be removed before deploying. #TODO
    layout
    {
        addlast(General)
        {
            field("CO2 Usage_PTE"; Rec."CO2 Usage_PTE")
            {
                ApplicationArea = All;
            }
            field("Include in CO2 Statistics_PTE"; Rec."Include in CO2 Statistics_PTE")
            {
                ApplicationArea = All;
            }
        }
    }
}