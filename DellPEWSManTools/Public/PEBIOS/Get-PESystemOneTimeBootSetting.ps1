<#
Get-PESystemOneTimeBootSetting.ps1 - Gets the PE system one time boot system, if configured.

_author_ = Ravikanth Chaganti <Ravikanth_Chaganti@Dell.com> _version_ = 1.0

Copyright (c) 2017, Dell, Inc.

This software is licensed to you under the GNU General Public License, version 2 (GPLv2). There is NO WARRANTY for this software, express or implied, including the implied warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. You should have received a copy of GPLv2 along with this software; if not, see http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt
#>
function Get-PESystemOneTimeBootSetting
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory)]
        [Alias("s")]
        [ValidateNotNullOrEmpty()]
        $iDRACSession      
    )

    Process
    {
        $oneTimeBootSetting = @{}
        $oneTimeBootMode = Get-PEBIOSAttribute -iDRACSession $iDRACSession -AttributeName OneTimeBootMode
        $oneTimeBootSetting.Add('OneTimeBootMode',$oneTimeBootMode.CurrentValue)
        if ($oneTimeBootMode.CurrentValue -ne 'Disabled')
        {
            $oneTimeBootDevice = Get-PEBIOSAttribute -iDRACSession $iDRACSession -AttributeName OneTimeUefiBootSeqDev
            $oneTimeBootSetting.Add('OneTimeBootDevice',$oneTimeBootDevice.CurrentValue)
        }

        return $oneTimeBootSetting
    }
}
