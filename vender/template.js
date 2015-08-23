var remote = require('remote');
var menu = remote.require('menu');
var template = [
  {
    label: 'electron',
    submenu: [
      {
        label: 'about electron',
        selector: 'orderfrontstandardaboutpanel:'
      },
      {
        type: 'separator'
      },
      {
        label: 'services',
        submenu: []
      },
      {
        type: 'separator'
      },
      {
        label: 'hide electron',
        accelerator: 'cmdorctrl+h',
        selector: 'hide:'
      },
      {
        label: 'hide others',
        accelerator: 'cmdorctrl+shift+h',
        selector: 'hideotherapplications:'
      },
      {
        label: 'show all',
        selector: 'unhideallapplications:'
      },
      {
        type: 'separator'
      },
      {
        label: 'quit',
        accelerator: 'cmdorctrl+q',
        selector: 'terminate:'
      },
    ]
  },
  {
    label: 'edit',
    submenu: [
      {
        label: 'undo',
        accelerator: 'cmdorctrl+z',
        selector: 'undo:'
      },
      {
        label: 'redo',
        accelerator: 'shift+cmdorctrl+z',
        selector: 'redo:'
      },
      {
        type: 'separator'
      },
      {
        label: 'cut',
        accelerator: 'cmdorctrl+x',
        selector: 'cut:'
      },
      {
        label: 'copy',
        accelerator: 'cmdorctrl+c',
        selector: 'copy:'
      },
      {
        label: 'paste',
        accelerator: 'cmdorctrl+v',
        selector: 'paste:'
      },
      {
        label: 'select all',
        accelerator: 'cmdorctrl+a',
        selector: 'selectall:'
      }
    ]
  },
  {
    label: 'view',
    submenu: [
      {
        label: 'reload',
        accelerator: 'cmdorctrl+r',
        click: function() { remote.getcurrentwindow().reload(); }
      },
      {
        label: 'toggle devtools',
        accelerator: 'alt+cmdorctrl+i',
        click: function() { remote.getcurrentwindow().toggledevtools(); }
      },
    ]
  },
  {
    label: 'window',
    submenu: [
      {
        label: 'minimize',
        accelerator: 'cmdorctrl+m',
        selector: 'performminiaturize:'
      },
      {
        label: 'close',
        accelerator: 'cmdorctrl+w',
        selector: 'performclose:'
      },
      {
        type: 'separator'
      },
      {
        label: 'bring all to front',
        selector: 'arrangeinfront:'
      }
    ]
  },
  {
    label: 'help',
    submenu: []
  }
];

menu = menu.buildfromtemplate(template);

menu.setapplicationmenu(menu);
