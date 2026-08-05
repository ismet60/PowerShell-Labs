Configuration SampleDSCConfig
{
    Node localhost
    {
        File SampleFile
        {
            Ensure = "Present"
            DestinationPath = "C:\DSCDemo\SampleFile.txt"
            Contents = "This is a dummy file created by DSC."
        }
    }
}

SampleDSCConfig -OutputPath 'C:\DSCDemo' -Verbose