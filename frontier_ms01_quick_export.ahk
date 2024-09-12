#Requires AutoHotkey v2.0

Export(export_name) {
  SetControlDelay -1

  If WinActive("View Orders") {
    ControlClick("View Images", "View Orders")
  }

  edit_window := ""

  If WinWaitActive("6 Frame UI", , 1) {
    edit_window := "6 Frame UI"
  } Else If WinWaitActive("View Frames", , 1) {
    edit_window := "View Frames"
  } Else {
    MsgBox("No order was selected.")
    Return
  }

  ControlClick("Add To Order", edit_window)
  If WinWaitActive("Order Summary") {
    index := ControlFindItem(export_name, "ComboBox5", "Order Summary")
    ControlChooseIndex(index, "ComboBox5", "Order Summary")
    ControlSetText("1", "Edit3")
    ControlClick("APPLY", "Order Summary")
    ControlClick("DONE", "Order Summary")
    If WinWaitActive(edit_window) {
      Sleep 300  ; sometimes AHK is too fast, and the UI doesn't allow Process Order until the images are loaded, so we wait a slight moment
      ControlClick("Process Order", edit_window)
    }
  }
}

+1:: Export("Export JPG 100Q")
+2:: Export("Export JPG 95Q")
+3:: Export("Export TIFF")
+BackSpace:: ExitApp()