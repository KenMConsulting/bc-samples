codeunit 50801 "Sample Dimension Codes"
{
    trigger OnRun()
    begin

    end;

    local procedure NewDimSetID(DimSetID: Integer; NewDimCode: Code[20]; NewDimValCode: Code[20]): Integer
    var
        TempDimenionSetEntry: record "Dimension Set Entry" temporary;
        DimMgt: Codeunit DimensionManagement;
        DimVal: Record "Dimension Value";
    begin
        if NewDimValCode <> '' then begin
            if not DimVal.get(NewDimCode, NewDimValCode) then
                error('Dimension ' + NewDimCode + ' Code ' + NewDimValCode + ' does not exist.');
        end;

        if not TempDimenionSetEntry.IsTemporary then
            error('Record must be temporary');

        TempDimenionSetEntry.Deleteall();

        //Get Current Dimension
        DimMgt.GetDimensionSet(TempDimenionSetEntry, DimSetID);

        //Delete Old dimension
        IF TempDimenionSetEntry.GET(TempDimenionSetEntry."Dimension Set ID", NewDimCode) THEN
            IF TempDimenionSetEntry."Dimension Value Code" <> NewDimValCode THEN
                TempDimenionSetEntry.DELETE;

        //Add new dimension
        IF NewDimValCode <> '' THEN BEGIN
            TempDimenionSetEntry."Dimension Code" := DimVal."Dimension Code";
            TempDimenionSetEntry."Dimension Value Code" := DimVal.Code;
            TempDimenionSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            IF TempDimenionSetEntry.INSERT THEN;
        END;

        exit(DimMgt.GetDimensionSetID(TempDimenionSetEntry));
    end;
}

