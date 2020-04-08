//   Copyright 2016 Esri
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at

//       http://www.apache.org/licenses/LICENSE-2.0

//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Xml;
using ArcGIS.Desktop.Framework;
using ArcGIS.Desktop.Framework.Threading.Tasks;
using ArcGIS.Desktop.Mapping;
using ArcGIS.Core.CIM;
using ICSharpCode.AvalonEdit;
using ICSharpCode.AvalonEdit.Document;
using ICSharpCode.AvalonEdit.Folding;
using ICSharpCode.AvalonEdit.Rendering;
using ICSharpCode.AvalonEdit.Search;
using CIMViewer.Helpers;
using System.Xml.XPath;
using System.IO;
using System.Xml.Linq;
using System.Drawing;

namespace CIMViewer.UI {
    /// <summary>
    /// Interaction logic for CIMViewer.xaml
    /// </summary>
    /// <remarks>Context menu and Cut, Copy, Paste issues for Avalon TextEditor:
    /// <a href="http://stackoverflow.com/questions/14909421/hooking-up-commands-in-avalonedit-used-in-listviews-itemtemplate-doesnt-work"/>
    /// </remarks>
    public partial class CIMViewer : UserControl, INotifyPropertyChanged {

        ////private TextEditor _editor;
        private FoldingManager _foldingManager;
        private XmlFoldingStrategy _xmlFolding;
        private CIMService _cimService = null;
        private string _validationText = "";
        private string _reportDir = @"C:\Temp\New folder";

        public event PropertyChangedEventHandler PropertyChanged = delegate { };

        public CIMViewer() {
            InitializeComponent();
            ReportDir = _reportDir;
            _foldingManager = FoldingManager.Install(this.AvalonTextEditor.TextArea);
            _xmlFolding = new XmlFoldingStrategy();
            //http://blog.jerrynixon.com/2013/07/solved-two-way-binding-inside-user.html
            (this.Content as FrameworkElement).DataContext = this;
            //this.AvalonTextEditor.DataContext = this;

            //http://stackoverflow.com/questions/13344982/does-avalonedit-texteditor-has-quick-search-replace-functionality
            this.AvalonTextEditor.TextArea.DefaultInputHandler.NestedInputHandlers.Add(
                new SearchInputHandler(this.AvalonTextEditor.TextArea));

            this.Loaded += (s, e) => {
                try {
                    this.AvalonTextEditor.ContextMenu.SetValue(CIMViewer.TextEditorProperty,
                        this.AvalonTextEditor);
                }
                catch (System.Exception ex) {
                    System.Diagnostics.Debug.WriteLine("Exception: {0}", ex.ToString());
                }
            };
        }

        private void TaskScheduler_UnobservedTaskException(object sender, UnobservedTaskExceptionEventArgs e) {
            throw new NotImplementedException();
        }

        #region CIMService Property

        public static readonly DependencyProperty CIMServiceProperty =
        DependencyProperty.Register("CIMService", typeof(CIMService), typeof(CIMViewer),
            new FrameworkPropertyMetadata(null,
                new PropertyChangedCallback(CIMServicePropertyChanged)));

        private static async void CIMServicePropertyChanged(DependencyObject sender, DependencyPropertyChangedEventArgs e) {
             CIMViewer _this = sender as CIMViewer;
            if (e.NewValue == null) {
                _this.AvalonTextEditor.Text = "";
                _this._cimService = null;
            }
            else {
                _this._cimService = (CIMService)e.NewValue;
                var xml = await _this._cimService.GetDefinitionAsync();
                _this.AvalonTextEditor.Text = FormatXml(xml);
                _this._xmlFolding.UpdateFoldings(_this._foldingManager, _this.AvalonTextEditor.Document);

            }
            //if (_this._cimService is mapmamber
            _this._validationText = "";
            _this.OnPropertyChanged("ValidationText");
        }




        public CIMService CIMService {
            get {
                return (CIMService)GetValue(CIMServiceProperty);
            }
            set {
                SetValue(CIMServiceProperty, value);
            }
        }

        #endregion CIMService Property

        #region TextEditor Property

        public static TextEditor GetTextEditor(ContextMenu menu) {
            return (TextEditor)menu.GetValue(TextEditorProperty);
        }

        public static void SetTextEditor(ContextMenu menu, TextEditor value) {
            menu.SetValue(TextEditorProperty, value);
        }

        public static readonly DependencyProperty TextEditorProperty =
            DependencyProperty.RegisterAttached("TextEditor", typeof(TextEditor), typeof(CIMViewer),
                new UIPropertyMetadata(null, OnTextEditorChanged));

        static void OnTextEditorChanged(DependencyObject depObj, DependencyPropertyChangedEventArgs e) {
            ContextMenu menu = depObj as ContextMenu;
            if (menu == null || e.NewValue is DependencyObject == false)
                return;
            TextEditor editor = (TextEditor)e.NewValue;
            NameScope.SetNameScope(menu, NameScope.GetNameScope(editor));
        }

        #endregion

        public string ValidationText => _validationText;
        public string ReportDir { get; set; }

        #region Commands

        ICommand _reportCommand;
        ICommand _refreshCommand;
        ICommand _saveCommand;
        ICommand _clearCommand;
        ICommand _validateCommand;
        ICommand _changeFontSizeCommand;


        public ICommand ReportCommand
        {
            get
            {
                return _reportCommand ?? (_reportCommand = new RelayCommand(async () => {
                    if (CIMService != null)
                    {
                        if (string.IsNullOrEmpty(ReportDir))
                        {
                            using (var fbd = new System.Windows.Forms.FolderBrowserDialog())
                            {
                                System.Windows.Forms.DialogResult result = fbd.ShowDialog();

                                if (result == System.Windows.Forms.DialogResult.OK && !string.IsNullOrWhiteSpace(fbd.SelectedPath))
                                {
                                    ReportDir = fbd.SelectedPath;
                                }
                            }
                        }
                        CIMViewerModule.IgnoreEvents = true;
                        var xml = await _cimService.GetDefinitionAsync();
                        
                        await saveReport(xml, ReportDir);
                        CIMViewerModule.IgnoreEvents = false;
                    }
                }));
            }
        }

        public ICommand RefreshCommand {
            get
            {
                return _refreshCommand ?? (_refreshCommand = new RelayCommand(async () => {
                    if (CIMService != null) {
                        CIMViewerModule.IgnoreEvents = true;
                        var xml = await _cimService.GetDefinitionAsync();
                        CIMViewerModule.IgnoreEvents = false;
                        this.AvalonTextEditor.Text = FormatXml(xml);
                        this._xmlFolding.UpdateFoldings(this._foldingManager, this.AvalonTextEditor.Document);
                        this._validationText = "";
                        this.OnPropertyChanged("ValidationText");
                    }
                }));
            }
        }

        public ICommand SaveCommand {
            get {
                return _saveCommand ?? (_saveCommand = new RelayCommand(async () => {
                    if (CIMService != null) {
                        if (!string.IsNullOrEmpty(this.AvalonTextEditor.Text)) {
                            try {
                                CIMViewerModule.IgnoreEvents = true;
                                await _cimService.SetDefinitionAsync(this.AvalonTextEditor.Text);
                                CIMViewerModule.IgnoreEvents = false;
                                MessageBox.Show("Definition saved", "Save", MessageBoxButton.OK,
                                    MessageBoxImage.Information);
                            }
                            catch (Exception ex) {
                                CIMViewerModule.IgnoreEvents = false;
                                MessageBox.Show(string.Format("Error saving definition {0}",
                                           ex.Message), "Save Error", MessageBoxButton.OK,
                                    MessageBoxImage.Error);
                            }

                        }
                    }
                }));
            }
        }

        public ICommand ClearCommand
        {
            get {
                return _clearCommand ?? (_clearCommand = new RelayCommand(() => CIMService = null));
            }
        }

        public ICommand ValidateCommand {
            get {
                return _validateCommand ?? (_validateCommand = new RelayCommand(() => Validate()));
            }
        }

        public ICommand ChangeFontSizeCommand
        {
            get
            {
                return _changeFontSizeCommand ?? (_changeFontSizeCommand = new RelayCommand(
                    (Action<object>)ChangeTextSize, (Func<bool>)(() => { return true; })));
            }
        }

        private void ChangeTextSize(object cmdParam) {
            string delta = cmdParam.ToString();

            this.AvalonTextEditor.FontSize = (delta == "-1"
                ? this.AvalonTextEditor.FontSize - 1
                : this.AvalonTextEditor.FontSize + 1);
        }

        #region Editing Commands

        CIMViewerCommand _copyCommand;
        CIMViewerCommand _pasteCommand;
        CIMViewerCommand _cutCommand;
        CIMViewerCommand _undoCommand;
        CIMViewerCommand _redoCommand;

        public CIMViewerCommand CutCommand {
            get {
                return _cutCommand ?? (_cutCommand = new CIMViewerCommand(ApplicationCommands.Cut));
            }
        }

        public CIMViewerCommand CopyCommand {
            get {
                return _copyCommand ?? (_copyCommand = new CIMViewerCommand(ApplicationCommands.Copy));
            }
        }

        public CIMViewerCommand PasteCommand {
            get {
                return _pasteCommand ?? (_pasteCommand = new CIMViewerCommand(ApplicationCommands.Paste));
            }
        }

        public CIMViewerCommand UndoCommand {
            get {
                return _undoCommand ?? (_undoCommand = new CIMViewerCommand(ApplicationCommands.Undo));
            }
        }

        public CIMViewerCommand RedoCommand {
            get {
                return _redoCommand ?? (_redoCommand = new CIMViewerCommand(ApplicationCommands.Redo));
            }
        }

        #endregion Editing Commands

        #endregion Commands

        private static string FormatXml(string xml) {
            var doc = new XmlDocument();
            var sb = new StringBuilder();
            try {
                doc.LoadXml(xml);
                var xmlWriterSettings = new XmlWriterSettings { Indent = true, OmitXmlDeclaration = true };
                doc.Save(XmlWriter.Create(sb, xmlWriterSettings));
            }
            catch (System.Xml.XmlException xmle) {
                System.Diagnostics.Debug.WriteLine("FormatXml Exception: {0}", xmle.ToString());
                sb.Append(xml);
            }
            return sb.ToString();
        }

        private Task saveReport(string xml, string outputDir)
        {
            return QueuedTask.Run(() => {

                var doc = new XmlDocument();
                try
                {
                    doc.LoadXml(xml);
                    XmlNodeList nodelist = doc.ChildNodes;
                    string str = "";
                    foreach (XmlNode node in nodelist)
                    {
                        XmlNode nd = node.SelectSingleNode("URI");
                        string _URIPath = nd.InnerText.Replace("CIMPATH=", "");
                        string _outPath = System.IO.Path.Combine(outputDir, System.IO.Path.GetDirectoryName(_URIPath));
                        string _URIFileName = System.IO.Path.GetFileNameWithoutExtension(_URIPath);
                        string _URIimgPath = System.IO.Path.Combine(_outPath, "img\\" + _URIFileName);
                        //string fname = nd.InnerText.Replace("CIMPATH=", "").Replace("/", "_").Replace(".xml", "");
                        switch (node.Name)
                        {
                            case "CIMFeatureLayer":
                                var cfl = CIMFeatureLayer.FromXml(xml);
                                GetRenderer(cfl.Renderer, node, outputDir);

                                str = TransformDocument(doc.InnerXml, System.IO.Path.Combine(System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location), @"Stylesheet\CIMFeatureLayer.xslt"), System.IO.Path.Combine(_outPath, _URIFileName));
                                break;
                            case "CIMMap":
                                str = TransformDocument(xml, System.IO.Path.Combine(System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location), @"Stylesheet\CIMMap.xslt"), System.IO.Path.Combine(_outPath, _URIFileName));
                                exportMapContent(xml, outputDir);
                                break;
                            case "CIMGroupLayer":
                                str = TransformDocument(xml, System.IO.Path.Combine(System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location), @"Stylesheet\CIMGroupLayer.xslt"), System.IO.Path.Combine(_outPath, _URIFileName));
                                break;
                            default:
                                str = TransformDocument(xml, System.IO.Path.Combine(System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location), @"Stylesheet\CIMFeatureLayer.xslt"), System.IO.Path.Combine(_outPath, _URIFileName));
                                break;
                        }
                    }
                    return doc;
                }
                catch (System.Xml.XmlException xmle)
                {
                    return null;
                }


            });


        }

        private void exportMapContent(string xml, string outputDir)
        {
            var doc = new XmlDocument();
            doc.LoadXml(xml);
            XmlNodeList nodelist = doc.ChildNodes;
            Map map = MapView.Active.Map;
            var cm = CIMMap.FromXml(xml);
            foreach (var layer in cm.Layers)
            {
                Layer lyr = map.FindLayer(layer, true);

                GetLayerNode(lyr, doc);

            }
            foreach (var st in cm.StandaloneTables)
            {
                StandaloneTable tbl = map.FindStandaloneTable(st);
                XmlNode lnd;
                lnd = doc.SelectSingleNode("//StandaloneTables/String[text()='" + tbl.URI + "']");
                CIMService cs = new MapMemberService((MapMember)tbl);
                var xmlLayer = cs.GetDefinitionAsync();
                XmlDocumentFragment xfrag = doc.CreateDocumentFragment();
                xfrag.InnerXml = xmlLayer.Result;
                XmlNode nd = xfrag.FirstChild;
                lnd.AppendChild(nd);
            }
            string str = TransformDocument(doc.InnerXml, System.IO.Path.Combine(System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location), @"Stylesheet\CIMMap.xslt"), System.IO.Path.Combine(outputDir, MakeValidFileName(map.Name) ));
        }

        private void GetLayerNode(Layer lyr, XmlDocument doc)
        {
            Layer plyr = MapView.Active.Map.FindLayer(lyr.URI, true);
            

            MapMember mm = lyr;
            XmlNode lnd;
            lnd = doc.SelectSingleNode("//Layers/String[text()='" + lyr.URI + "']");
            CIMService cs = new MapMemberService((MapMember)lyr);
            //var xmlLayer = GetlayerDefinitionAsync(lyr);
            var xmlLayer = cs.GetDefinitionAsync();
            XmlDocumentFragment xfrag = doc.CreateDocumentFragment();
            xfrag.InnerXml = xmlLayer.Result;
            XmlNode nd = xfrag.FirstChild;

            switch (lyr.GetType().Name)
            {
                case "GroupLayer":
                    lnd.AppendChild(xfrag);
                    GroupLayer glyr = (GroupLayer)lyr;
                    foreach (var layer in glyr.Layers)
                    {
                        lnd = doc.SelectSingleNode("//Layers/String[text()='" + lyr.URI + "']");
                        GetLayerNode(layer, doc);
                    }
                    break;
                case "FeatureLayer":
                    var cfl = CIMFeatureLayer.FromXml(xmlLayer.Result);
                    
                    GetRenderer(cfl.Renderer, nd, ReportDir);
                    lnd.AppendChild(nd);
                    break;
                case "RasterLayer":
                    var crl = CIMRasterLayer.FromXml(xmlLayer.Result);
                    //GetRenderer(crl., nd, ReportDir);
                    lnd.AppendChild(nd);
                    break;
                case "StandaloneTable":
                    lnd = doc.SelectSingleNode("//StandaloneTables/String[text()='" + lyr.URI + "']");
                    lnd.AppendChild(nd);
                    break;
                default:
                    lnd.AppendChild(nd);
                    break;
            }
            
        }
        public static Task<string> GetlayerDefinitionAsync(Layer mm)
        {
            return QueuedTask.Run(() => {
                if (mm == null)
                    return "";
                if (mm is Layer)
                    return ((Layer)mm).GetDefinition()?.ToXml() ?? "";
                return null;
            });
        }

        private void GetRenderer(CIMRenderer renderer, XmlNode node, string outputDir)
        {
            XmlNode nd = node.SelectSingleNode("//URI");
            string _URIPath = nd.InnerText.Replace("CIMPATH=", "");
            string _outPath = System.IO.Path.Combine(outputDir, System.IO.Path.GetDirectoryName(_URIPath));
            string _URIFileName = System.IO.Path.GetFileNameWithoutExtension(_URIPath);
            string _imgPath = System.IO.Path.Combine(_outPath, "img\\" + _URIFileName);
            string _imgPathRelative = "/img" + _URIFileName;
            string _imgFullPath = "";
            switch (renderer.GetType().Name)
                {
                case "CIMSimpleRenderer":
                    var simpleRenderer = renderer as CIMSimpleRenderer;

                    //CIMSymbol symbol = SymbolFactory.Instance.ConstructPointSymbol(ColorFactory.Instance.GreenRGB, 1.0, SimpleMarkerStyle.Circle);
                    //You can generate a swatch for a text symbols also.
                    _imgFullPath = System.IO.Path.Combine(_imgPath, _URIFileName + "_Default.png");
                    BitmapSource bs_simpleRenderer = SavePicturetoFile3(simpleRenderer.Symbol.Symbol, _imgFullPath);
                    XmlNode nd_simpleRenderer = node.SelectSingleNode("Renderer/Symbol/Symbol");
                    XmlNode nd2 = nd_simpleRenderer.AppendChild(XmlUtility.CreateTextElement(nd_simpleRenderer, "picture", ToBase64(bs_simpleRenderer, "PNG")));
                    XmlNode nd5 = nd_simpleRenderer.AppendChild(XmlUtility.CreateTextElement(nd2, "picturePath", _imgPathRelative + _URIFileName + "_Default.png"));
                    bs_simpleRenderer = null;
                    //nd_simpleRenderer.AppendChild(nd2);
                    break;
                case "CIMUniqueValueRenderer":
                    _imgFullPath = System.IO.Path.Combine(_imgPath, _URIFileName + "_Default.png");
                    var uniqueValueRenderer = renderer as CIMUniqueValueRenderer;
                    BitmapSource bs_uniqueValueRenderer = SavePicturetoFile3(uniqueValueRenderer.DefaultSymbol.Symbol, _imgFullPath);
                    XmlNode nd_uniqueValueRenderer = node.SelectSingleNode("Renderer/DefaultSymbol/Symbol");
                    XmlNode nd3 = nd_uniqueValueRenderer.AppendChild(XmlUtility.CreateTextElement(nd_uniqueValueRenderer, "picture", ToBase64(bs_uniqueValueRenderer,"PNG")));
                    XmlNode nd6 = nd_uniqueValueRenderer.AppendChild(XmlUtility.CreateTextElement(nd3, "picturePath", _imgPathRelative + _URIFileName + "_Default.png"));
                    bs_uniqueValueRenderer = null;
                    foreach (CIMUniqueValueGroup uvg in uniqueValueRenderer.Groups)
                    {
                        foreach (CIMUniqueValueClass uvc in uvg.Classes)
                        {
                            _imgFullPath = System.IO.Path.Combine(_imgPath, _URIFileName + "_" + (string.IsNullOrEmpty(uvc.Label) ? System.IO.Path.GetRandomFileName() : MakeValidFileName(uvc.Label) + ".png"));
                            BitmapSource bs_uniqueValueClass = SavePicturetoFile3(uvc.Symbol.Symbol, _imgFullPath);
                            XmlNode nd_uniqueValueClass = node.SelectSingleNode("//CIMUniqueValueClass[Label='" + uvc.Label + "']");
                            XmlNode nd4 = nd_uniqueValueClass.AppendChild(XmlUtility.CreateTextElement(nd_uniqueValueClass, "picture", ToBase64(bs_uniqueValueClass, "PNG")));
                            XmlNode nd7 = nd_uniqueValueClass.AppendChild(XmlUtility.CreateTextElement(nd4, "picturePath", _imgPathRelative + _URIFileName + "_" + (string.IsNullOrEmpty(uvc.Label) ? System.IO.Path.GetRandomFileName() : MakeValidFileName(uvc.Label) + ".png")));
                            bs_uniqueValueClass = null;
                        }
                    }
                    break;
                default:
                    break;
            }
        }
        public static System.Drawing.Bitmap BitmapSourceToBitmap2(BitmapSource bitmapsource)
        {
            System.Drawing.Bitmap bitmap;
            using (MemoryStream outStream = new MemoryStream())
            {
                BitmapEncoder enc = new BmpBitmapEncoder();
                enc.Frames.Add(BitmapFrame.Create(bitmapsource));
                enc.Save(outStream);
                bitmap = new System.Drawing.Bitmap(outStream);
            }
            return bitmap;
        }

        private static string ToBase64(BitmapSource image, string format)
        {
            return Convert.ToBase64String(Encode(image, format));
        }

        private static Stream FromBase64(string content)
        {
            return new MemoryStream(Convert.FromBase64String(content));
        }

        private static byte[] Encode(BitmapSource bitmapImage, string format)
        {
            byte[] data = null;
            BitmapEncoder encoder = null;
            switch (format.ToUpper())
            {
                case "PNG":
                    encoder = new PngBitmapEncoder();
                    break;
                case "GIF":
                    encoder = new GifBitmapEncoder();
                    break;
                case "BMP":
                    encoder = new BmpBitmapEncoder();
                    break;
                case "JPG":
                    encoder = new JpegBitmapEncoder();
                    break;
            }
            if (encoder != null)
            {
                encoder.Frames.Add(BitmapFrame.Create(bitmapImage));
                using (var ms = new MemoryStream())
                {
                    encoder.Save(ms);
                    ms.Seek(0, SeekOrigin.Begin);
                    data = ms.ToArray();
                }
            }

            return data;
        }

        public static BitmapImage ToBitmapImage(Stream stream)
        {
            try
            {
                var bitmap = new BitmapImage();
                bitmap.BeginInit();
                bitmap.CreateOptions = BitmapCreateOptions.PreservePixelFormat;
                bitmap.CacheOption = BitmapCacheOption.OnLoad;
                bitmap.StreamSource = stream;
                bitmap.EndInit();
                return bitmap;
            }
            catch (Exception ex)
            {


            }

            return null;
        }
        private static string TransformDocument(string doc, string stylesheetPath, string outFile)
        {
            Func<string, XmlDocument> GetXmlDocument = (xmlContent) =>
            {
                XmlDocument xmlDocument = new XmlDocument();
                xmlDocument.LoadXml(xmlContent);
                return xmlDocument;
            };

            try
            {
                String PItext = @"type='text/xsl' href='file:///d:/GitHub/arcgis-pro-sdk-cim-viewer/CIMViewer/Stylesheet/CIMFeatureLayer.xslt'";
                PItext = "<?xml-stylesheet " + PItext + " ?>" + doc;
                var document = GetXmlDocument(PItext);
                var style = GetXmlDocument(File.ReadAllText(stylesheetPath));

                System.Xml.Xsl.XslCompiledTransform transform = new System.Xml.Xsl.XslCompiledTransform();
                transform.Load(style); // compiled stylesheet
                System.IO.StringWriter writer = new System.IO.StringWriter();
                XmlReader xmlReadB = new XmlTextReader(new StringReader(document.DocumentElement.OuterXml));
                transform.Transform(xmlReadB, null, writer);
                File.WriteAllText(outFile + ".html", writer.ToString());
                
                document.Save(outFile+ ".xml");

                return writer.ToString();

            }
            catch (Exception ex)
            {
                return null;
                //throw ex;
            }

        }

        private ImageSource getSymbolPicture(CIMRenderer renderer)
        {
            ImageSource _symbolPicture = null;
            switch (renderer.GetType().Name)
            {

                case "CIMSimpleRenderer":
                    var simpleRenderer = renderer as CIMSimpleRenderer;

                    //CIMSymbol symbol = SymbolFactory.Instance.ConstructPointSymbol(ColorFactory.Instance.GreenRGB, 1.0, SimpleMarkerStyle.Circle);
                    //You can generate a swatch for a text symbols also.
                    var si = new SymbolStyleItem()
                    {
                        Symbol = simpleRenderer.Symbol.Symbol,
                        PatchHeight = 32,
                        PatchWidth = 32
                    };
                    _symbolPicture = si.PreviewImage;
                    
                    break;
                case "CIMUniqueValueRenderer":
                    var uniqueValueRenderer = renderer as CIMUniqueValueRenderer;
                    var si1 = new SymbolStyleItem()
                    {
                        Symbol = uniqueValueRenderer.DefaultSymbol.Symbol,
                        PatchHeight = 32,
                        PatchWidth = 32
                    };
                    _symbolPicture = si1.PreviewImage;

                    break;
                default:
                    break;
            }
            return _symbolPicture;
        }

        private void SavePicturetoFile(ImageSource symbolPicture, string outputDir, string fname)
        {
            FileStream fs = new FileStream(System.IO.Path.Combine(outputDir, fname), FileMode.Create);
            var encoder = new System.Windows.Media.Imaging.PngBitmapEncoder();
            encoder.Frames.Add(System.Windows.Media.Imaging.BitmapFrame.Create(symbolPicture as System.Windows.Media.Imaging.BitmapSource));
            encoder.Save(fs);
            fs.Flush();
        }

        private BitmapSource SavePicturetoFile2(CIMSymbol cimSymbol, string outputDir, string fname)
        {
            var si1 = new SymbolStyleItem()
            {
                Symbol = cimSymbol,
                PatchHeight = 32,
                PatchWidth = 32
            };
            ImageSource _symbolPicture = si1.PreviewImage;
            Directory.CreateDirectory(System.IO.Path.GetDirectoryName(System.IO.Path.Combine(outputDir, fname)));
            FileStream fs = new FileStream(System.IO.Path.Combine(outputDir, fname), FileMode.Create);
            var encoder = new System.Windows.Media.Imaging.PngBitmapEncoder();
            encoder.Frames.Add(System.Windows.Media.Imaging.BitmapFrame.Create(_symbolPicture as System.Windows.Media.Imaging.BitmapSource));
            encoder.Save(fs);
            fs.Flush();
            return _symbolPicture as System.Windows.Media.Imaging.BitmapSource;
        }

        private BitmapSource SavePicturetoFile3(CIMSymbol cimSymbol, string fname)
        {
            var si1 = new SymbolStyleItem()
            {
                Symbol = cimSymbol,
                PatchHeight = 32,
                PatchWidth = 32
            };
            ImageSource _symbolPicture = si1.PreviewImage;
            Directory.CreateDirectory(System.IO.Path.GetDirectoryName(fname));
            FileStream fs = new FileStream(fname, FileMode.Create);
            var encoder = new System.Windows.Media.Imaging.PngBitmapEncoder();
            encoder.Frames.Add(System.Windows.Media.Imaging.BitmapFrame.Create(_symbolPicture as System.Windows.Media.Imaging.BitmapSource));
            encoder.Save(fs);
            fs.Flush();
            return _symbolPicture as System.Windows.Media.Imaging.BitmapSource;
        }

        private ImageSource SavePicturetoFile4(CIMSymbol cimSymbol, string fname)
        {
            var si1 = new SymbolStyleItem()
            {
                Symbol = cimSymbol,
                PatchHeight = 32,
                PatchWidth = 32
            };
            ImageSource _symbolPicture = si1.PreviewImage;
            Directory.CreateDirectory(System.IO.Path.GetDirectoryName(fname));
            FileStream fs = new FileStream(fname, FileMode.Create);
            var encoder = new System.Windows.Media.Imaging.PngBitmapEncoder();
            encoder.Frames.Add(System.Windows.Media.Imaging.BitmapFrame.Create(_symbolPicture as System.Windows.Media.Imaging.BitmapSource));
            encoder.Save(fs);
            fs.Flush();
            return _symbolPicture;
        }

        private static string MakeValidFileName(string name)
        {
            string invalidChars = System.Text.RegularExpressions.Regex.Escape(new string(System.IO.Path.GetInvalidFileNameChars()));
            string invalidRegStr = string.Format(@"([{0}]*\.+$)|([{0}]+)", invalidChars);

            return System.Text.RegularExpressions.Regex.Replace(name, invalidRegStr, "_");
        }

        private static Task getSwatch(CIMSymbol symbol)
        {
            return QueuedTask.Run(() => {
                //CIMSymbol symbol = SymbolFactory.Instance.ConstructPointSymbol(ColorFactory.Instance.GreenRGB, 1.0, SimpleMarkerStyle.Circle);
                //You can generate a swatch for a text symbols also.
                var si = new SymbolStyleItem()
                {
                    Symbol = symbol,
                    PatchHeight = 64,
                    PatchWidth = 64
                };
                return si.PreviewImage;
            });
        }

        private void Validate() {

            try {
                var document = new XmlDocument { XmlResolver = null };
                document.LoadXml(this.AvalonTextEditor.Text);
                _validationText = "No errors";
            }
            catch (XmlException ex) {
                _validationText = string.Format("Error: {0}\r\n", ex.Message);
                DisplayValidationError(ex.Message, ex.LinePosition, ex.LineNumber);
            }
            this.Validation.IsExpanded = true;
            OnPropertyChanged("ValidationText");
        }

        private void DisplayValidationError(string message, int linePosition, int lineNumber) {
            if (lineNumber >= 1 && lineNumber <= this.AvalonTextEditor.Document.LineCount) {
                int index = message.ToLower().IndexOf(" line ");
                int index2 = -1;
                int beginLine = -1;
                int beginPos = -1;
                int offset1 = -1;
                //Example error message:
                //"The 'VerticalExaggeration' start tag on line 24 position 29 does not match the end tag of 'Layer3DProperties'.
                if (index >= 0) {
                    index2 = message.Substring(index + 6).ToLower().IndexOf(" position ");
                    string line = message.Substring(index + 6, index2).Replace(",","").Trim();

                    //now position
                    string remainder = message.Substring(index + 6 + index2 + 10);
                    string position = remainder.Substring(0, remainder.IndexOf(" ")).Replace(",", "").Trim();

                    if (Int32.TryParse(line, out beginLine) && Int32.TryParse(position, out beginPos)) {
                        offset1 = this.AvalonTextEditor.Document.GetOffset(new TextLocation(beginLine, beginPos - 1));
                    }
                }
                int offset2 = this.AvalonTextEditor.Document.GetOffset(new TextLocation(lineNumber, linePosition));
                if (offset1 > 0) {
                    this.AvalonTextEditor.Select(offset1, (offset2 - offset1));
                }
                else {
                    offset1 = this.AvalonTextEditor.Document.GetOffset(new TextLocation(lineNumber, 0));
                    this.AvalonTextEditor.Select(offset2, (offset2 - offset1));
                }
            }
        }

        protected virtual void OnPropertyChanged([CallerMemberName] string propName = "") {
            PropertyChanged(this, new PropertyChangedEventArgs(propName));
        }

        private void UIElement_OnMouseWheel(object sender, MouseWheelEventArgs e) {
            double val = (e.Delta < 0
                ? this.AvalonTextEditor.FontSize - 1
                : this.AvalonTextEditor.FontSize + 1);
            this.AvalonTextEditor.FontSize = (val == 0 ? 1 : val);
        }

        private void TextBox_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            using (var fbd = new System.Windows.Forms.FolderBrowserDialog())
            {
                System.Windows.Forms.DialogResult result = fbd.ShowDialog();

                if (result == System.Windows.Forms.DialogResult.OK && !string.IsNullOrWhiteSpace(fbd.SelectedPath))
                {
                    ReportDir = fbd.SelectedPath;
                }
            }
        }
    }
}
