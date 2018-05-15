Function Check-OsUpdate
{
    begin
    {}
    process
    {
        $osUpdate = @{}
        $windowsUpdate = New-Object -ComObject "Microsoft.Update.AutoUpdate"

        <# 
        #リモートからは取得できない 

        $NotificationLevelMsg =""

        switch ($windowsUpdate.Settings.NotificationLevel) {
            0 { $notificationLevelMsg = '未設定' }
            1 { $notificationLevelMsg = '更新プログラムを確認しない（推奨されません）' }
            2 { $notificationLevelMsg = '更新プログラムを確認するが、ダウンロードとインストールを行うかは選択する' }
            3 { $notificationLevelMsg = '更新プログラムをダウンロードするが、インストールを行うかは選択する' }
            4 { $notificationLevelMsg = '更新プログラムを自動的にインストールする（推奨）' }
            default { $notificationLevelMsg = "不明($($windowsUpdate.Settings.NotificationLevel))" }
        }

        $osUpdate["「重要な更新プログラム」の設定"] = $notificationLevelMsg
        #>

        # 取得値はUTCのため9時間進める: .AddHours(9)
        $osUpdate["更新プログラムの最終確認日時"] = $windowsUpdate.Results.LastSearchSuccessDate.AddHours(9)
        $osUpdate["更新プログラムのインストール日時"] = $windowsUpdate.Results.LastInstallationSuccessDate.AddHours(9)
        $osUpdate["最終インストール日からの経過日数"] = ((Get-Date) - $windowsUpdate.Results.LastInstallationSuccessDate).Days

        # 出力
        return $osUpdate
    }
    end
    {}
}
# 関数実行
Check-OsUpdate