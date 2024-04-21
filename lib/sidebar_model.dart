class SideBarModel {
  bool _open;
  bool _showItem;

  SideBarModel(
    this._open,
    this._showItem,
  );

  get open => _open;

  get showItem => _showItem;

  set showItem(value) => _showItem = value;
  
  set open(value) => _open = value;
}
