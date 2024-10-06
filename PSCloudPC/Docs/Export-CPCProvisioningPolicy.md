---
external help file: PSCloudPC-help.xml
Module Name: PSCloudPC
online version:
schema: 2.0.0
---

# Export-CPCProvisioningPolicy

## SYNOPSIS
Returns all Provisioning Policy's or Provisioning Policy's with a specific name

## SYNTAX

```
Export-CPCProvisioningPolicy -Name <String> -OutputFolder <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The function will return all Provisioning Policy's or Provisioning Policy's with a specific name

## EXAMPLES

### EXAMPLE 1
```
Export-CPCProvisioningPolicy -name "ProvisioningPolicy01" -OutputFolder "C:\Temp"
```

## PARAMETERS

### -Name
Enter the name of the Provisioning Policy

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputFolder
{{ Fill OutputFolder Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS