using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

public class XmlUtility
{
    public static XmlAttribute CreateAttribute(XmlNode node, string name, object value)
    {
        XmlAttribute attribute = node.OwnerDocument.CreateAttribute(name);
        attribute.Value = value.ToString();
        node.Attributes.Append(attribute);
        return attribute;
    }

    public static XmlElement CreateTextElement(XmlNode node, string name, string value)
    {
        StringBuilder sb = new StringBuilder();
        using (XmlTextWriter writer = new XmlTextWriter(new StringWriter(sb)))
        {
            writer.WriteString(value);
        }
        XmlElement element = node.OwnerDocument.CreateElement(name, node.NamespaceURI);
        element.InnerText = sb.ToString();
        node.AppendChild(element);
        return element;
    }

    public static XmlElement CreateImageElement(XmlNode node, string name, Image image)
    {
        XmlElement imageElement;
        using (var stream = new MemoryStream())
        {
            image.Save(stream, ImageFormat.Png);
            byte[] imageBytes = stream.ToArray();
            String imageBase64String = Convert.ToBase64String(imageBytes);
            imageElement = CreateTextElement(node, name, imageBase64String);
        }
        return imageElement;
    }

    public static Image ReadImageElement(XmlElement node)
    {
        Image image;
        byte[] imageBytes = Convert.FromBase64String(node.InnerText);
        using (var stream = new MemoryStream(imageBytes))
        {
            image = Bitmap.FromStream(stream);
            return image;
        }
    }

}