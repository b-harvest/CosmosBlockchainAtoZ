


vi crescent/cmd/crescentd/main.go

then

go mod tidy
make install

---

package main
  
import (
        "os"
        "time"
        "github.com/pkg/profile"
        "github.com/cosmos/cosmos-sdk/server"
        svrcmd "github.com/cosmos/cosmos-sdk/server/cmd"

        chain "github.com/crescent-network/crescent/v3/app"
        "github.com/crescent-network/crescent/v3/cmd/crescentd/cmd"
)

func main() {
        go func() {
                time.Sleep(time.Duration(30) * time.Second)

                p := profile.Start(profile.CPUProfile, profile.ProfilePath("./profileData"), profile.NoShutdownHook)
                time.Sleep(time.Duration(30) * time.Second)
                p.Stop()
                p = profile.Start(profile.MemProfile, profile.ProfilePath("./profileData"), profile.NoShutdownHook)
                time.Sleep(time.Duration(30) * time.Second)
                p.Stop()
                p = profile.Start(profile.GoroutineProfile, profile.ProfilePath("./profileData"), profile.NoShutdownHook)
                time.Sleep(time.Duration(30) * time.Second)
                p.Stop()
                p = profile.Start(profile.TraceProfile, profile.ProfilePath("./profileData"), profile.NoShutdownHook)
                time.Sleep(time.Duration(30) * time.Second)
                p.Stop()
        }()

        rootCmd, _ := cmd.NewRootCmd()

        if err := svrcmd.Execute(rootCmd, chain.DefaultNodeHome); err != nil {
                switch e := err.(type) {
                case server.ErrorCode:
                        os.Exit(e.Code)

                default:
                        os.Exit(1)
                }
        }
}
