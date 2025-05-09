package util;

import java.io.StringReader;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class XmlMapper {

	// xml -> Map
	public static Map<String, Object> toMap(String xml) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder bulider = factory.newDocumentBuilder();
		StringReader reader = new StringReader(xml);
		Document doc = bulider.parse(new InputSource(reader));// 문자열 XML--> 문서객체로 볂솬
		
		Element root = doc.getDocumentElement();	//루트 요소
		NodeList nodeList = root.getChildNodes();	// 자식 요소 리스트
		
		for (int i = 0; i < nodeList.getLength(); i++) {
			Node node = nodeList.item(i);			// i 번째 요소 : <name>, <age>
			if (node instanceof Element) {
				// name : ALOHA, age : 20
				map.put(node.getNodeName(), node.getTextContent());
				
			}
			
		}
		return map;
	}
}
