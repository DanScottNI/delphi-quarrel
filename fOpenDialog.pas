unit fOpenDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, FileCtrl, Dialogs;

type
  TfrmOpenDialog = class(TForm)
    DriveComboBox: TDriveComboBox;
    DirectoryListBox: TDirectoryListBox;
    FileListBox: TFileListBox;
    FilterComboBox: TFilterComboBox;
    cmdOK: TButton;
    cmdCancel: TButton;
    lblFilter: TLabel;
    procedure cmdOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FileListBoxDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    Filename : String;
    OpenDir : String;
    { Public declarations }
  end;

var
  frmOpenDialog: TfrmOpenDialog;

implementation

{$R *.dfm}

procedure TfrmOpenDialog.cmdOKClick(Sender: TObject);
begin
  if FileExists(FileListbox.FileName) = true then
  begin
    Filename := FileListBox.FileName;
    modalresult := mrOK;
  end
  else
    MessageDlg('Please select a valid file.', mtError, [mbOK], 0);

end;

procedure TfrmOpenDialog.FormShow(Sender: TObject);
begin
  DirectoryListBox.Directory := OpenDir;
end;

procedure TfrmOpenDialog.FileListBoxDblClick(Sender: TObject);
begin
//  Filename := FileListBox.FileName;
//  modalresult := mrOk;
end;

end.
