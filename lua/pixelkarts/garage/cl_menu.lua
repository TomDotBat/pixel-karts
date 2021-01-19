
function PIXEL.Karts.OpenGarageMenu(data)
    PIXEL.Karts.FlipGarageDoor(true)
    PIXEL.Karts.StartGarageRadio()
    PIXEL.Karts.CreatePreviewKart()
    PIXEL.Karts.SetupGarageCamera()
end

function PIXEL.Karts.CloseGarageMenu()
    PIXEL.Karts.FadeOutGarageRadio()
    PIXEL.Karts.CloseGarageDoor()
    PIXEL.Karts.RemoveGarageCamera()
    PIXEL.Karts.RemoveDecorations()

    timer.Simple(1, function()
        PIXEL.Karts.FlipGarageDoor(false)
    end)
end