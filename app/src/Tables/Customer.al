tableextension 50000 "Customer_PTE" extends Customer
{
    // This code is created as an example and must be removed before deploying. #TODO
    fields
    {
        field(50000; "CO2 Usage_PTE"; Decimal)
        {
            Caption = 'CO2 Usage', Comment = 'DAN="CO2-forbrug"';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the CO2 Usage for this Customer.', Comment = 'DAN="Angiver kundens CO2-forbrug."';

            trigger OnValidate()
            begin
                UpdateIncludeInCO2Statistics();
            end;
        }
        field(50001; "Include in CO2 Statistics_PTE"; Boolean)
        {
            Caption = 'Include in CO2 Statistic', Comment = 'DAN="Inkluder i CO2-statistik"';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies if the Customer is included in the CO2 Statistics.', Comment = 'DAN="Angiver om kunden er inkluderet i CO2-forbrugsstatistikker"';

            trigger OnValidate()
            var
                SetIncludedInCO2Statistics: Codeunit SetIncludedInCO2Statistics_PTE;
            begin
                SetIncludedInCO2Statistics.SetIncludedInCO2Statistics(Rec, xRec);
            end;
        }
    }

    local procedure UpdateIncludeInCO2Statistics()
    begin
        if "CO2 Usage_PTE" <> 0 then
            Validate("Include in CO2 Statistics_PTE", true)
        else
            Validate("Include in CO2 Statistics_PTE", false);
    end;
}