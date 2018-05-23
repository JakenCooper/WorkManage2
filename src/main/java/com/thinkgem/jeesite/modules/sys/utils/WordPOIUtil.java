package com.thinkgem.jeesite.modules.sys.utils;
  
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.poi.POIXMLDocument;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;


/**
 * doc工具类
 * @author wangna
 *
 */
public class WordPOIUtil {  
  
    // 返回Docx中需要替换的特殊字符，没有重复项  
    // 推荐传入正则表达式参数"\\$\\{[^{}]+\\}"  
    public ArrayList<String> getReplaceElementsInWord(String filePath,  
            String regex) {  
        String[] p = filePath.split("\\.");  
        if (p.length > 0) {// 判断文件有无扩展名  
            // 比较文件扩展名  
            if (p[p.length - 1].equalsIgnoreCase("doc")) {  
                ArrayList<String> al = new ArrayList<String>();  
                File file = new File(filePath);  
                HWPFDocument document = null;  
                try {  
                    InputStream is = new FileInputStream(file);  
                    document = new HWPFDocument(is);
                } catch (FileNotFoundException e) {  
                    e.printStackTrace();  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
                Range range = document.getRange();  
                String rangeText = range.text();  
                CharSequence cs = rangeText.subSequence(0, rangeText.length());  
                Pattern pattern = Pattern.compile(regex);  
                Matcher matcher = pattern.matcher(cs);  
                int startPosition = 0;  
                while (matcher.find(startPosition)) {  
                    if (!al.contains(matcher.group())) {  
                        al.add(matcher.group());  
                    }  
                    startPosition = matcher.end();  
                }  
                return al;  
            } else if (p[p.length - 1].equalsIgnoreCase("docx")) {  
                ArrayList<String> al = new ArrayList<String>();  
                XWPFDocument document = null;  
                try {  
                    document = new XWPFDocument(  
                            POIXMLDocument.openPackage(filePath));  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
                // 遍历段落  
                Iterator<XWPFParagraph> itPara = document  
                        .getParagraphsIterator();  
                while (itPara.hasNext()) {  
                    XWPFParagraph paragraph = (XWPFParagraph) itPara.next();  
                    String paragraphString = paragraph.getText();  
                    CharSequence cs = paragraphString.subSequence(0,  
                            paragraphString.length());  
                    Pattern pattern = Pattern.compile(regex);  
                    Matcher matcher = pattern.matcher(cs);  
                    int startPosition = 0;  
                    while (matcher.find(startPosition)) {  
                        if (!al.contains(matcher.group())) {  
                            al.add(matcher.group());  
                        }  
                        startPosition = matcher.end();  
                    }  
                }
                // 遍历表  
                Iterator<XWPFTable> itTable = document.getTablesIterator();  
                while (itTable.hasNext()) {  
                    XWPFTable table = (XWPFTable) itTable.next();  
                    int rcount = table.getNumberOfRows();  
                    for (int i = 0; i < rcount; i++) {  
                        XWPFTableRow row = table.getRow(i);  
                        List<XWPFTableCell> cells = row.getTableCells();  
                        for (XWPFTableCell cell : cells) {  
                            String cellText = "";  
                            cellText = cell.getText();  
                            CharSequence cs = cellText.subSequence(0,  
                                    cellText.length());  
                            Pattern pattern = Pattern.compile(regex);  
                            Matcher matcher = pattern.matcher(cs);  
                            int startPosition = 0;  
                            while (matcher.find(startPosition)) {  
                                if (!al.contains(matcher.group())) {  
                                    al.add(matcher.group());  
                                }  
                                startPosition = matcher.end();  
                            }  
                        }  
                    }  
                }  
                return al;  
            } else {  
                return null;  
            }  
        } else {  
            return null;  
        }  
    }
    
    /**
     * 替换原模板word中特殊字符并生成word
     * @param srcPath 原模板word地址 
     * @param destPath 生成的word 存放地址
     * @param map 替换字段map key:原模板doc中特殊字符；value:替换的内容
     * 注：doc 只能生成 doc；docx 只能生成 docx
     * @return
     */
    public static boolean replaceAndGenerateWord(String srcPath,  
            String destPath, Map<String, String> map) {  
        String[] sp = srcPath.split("\\.");  
        String[] dp = destPath.split("\\.");  
        if ((sp.length > 0) && (dp.length > 0)) {// 判断文件有无扩展名  
            // 比较文件扩展名  
            if (sp[sp.length - 1].equalsIgnoreCase("docx")) {  
                try {  
                    XWPFDocument document = new XWPFDocument(  
                            POIXMLDocument.openPackage(srcPath));  
                    // 替换段落中的指定文字  
                    Iterator<XWPFParagraph> itPara = document  
                            .getParagraphsIterator();  
                    while (itPara.hasNext()) {  
                        XWPFParagraph paragraph = (XWPFParagraph) itPara.next();  
                        List<XWPFRun> runs = paragraph.getRuns();  
                        for (int i = 0; i < runs.size(); i++) {  
                            String oneparaString = runs.get(i).getText(  
                                    runs.get(i).getTextPosition());  
                            for (Map.Entry<String, String> entry : map  
                                    .entrySet()) {  
                                oneparaString = oneparaString.replace(  
                                        entry.getKey(), entry.getValue());  
                            }  
                            runs.get(i).setText(oneparaString, 0);  
                        }  
                    }  
  
                    // 替换表格中的指定文字  
                    Iterator<XWPFTable> itTable = document.getTablesIterator();  
                    while (itTable.hasNext()) {  
                        XWPFTable table = (XWPFTable) itTable.next();  
                        int rcount = table.getNumberOfRows();  
                        for (int i = 0; i < rcount; i++) {  
                            XWPFTableRow row = table.getRow(i);  
                            List<XWPFTableCell> cells = row.getTableCells();  
                            for (XWPFTableCell cell : cells) {  
                                String cellTextString = cell.getText();  
                                for (Entry<String, String> e : map.entrySet()) {  
                                    if (cellTextString.contains(e.getKey()))  
                                        cellTextString = cellTextString  
                                                .replace(e.getKey(),  
                                                        e.getValue());  
                                }  
                                cell.removeParagraph(0);  
                                cell.setText(cellTextString);  
                            }  
                        }  
                    }  
                    FileOutputStream outStream = null;  
                    outStream = new FileOutputStream(destPath);  
                    document.write(outStream);  
                    outStream.close();  
                    return true;  
                } catch (Exception e) {  
                    e.printStackTrace();  
                    return false;  
                }  
  
            } else  
            // doc只能生成doc，如果生成docx会出错  
            if ((sp[sp.length - 1].equalsIgnoreCase("doc"))  
                    && (dp[dp.length - 1].equalsIgnoreCase("doc"))) {  
                HWPFDocument document = null;  
                try {  
                    document = new HWPFDocument(new FileInputStream(srcPath));  
                    Range range = document.getRange();  
                    for (Map.Entry<String, String> entry : map.entrySet()) {  
                        range.replaceText(entry.getKey(), entry.getValue());  
                    }  
                    FileOutputStream outStream = null;  
                    outStream = new FileOutputStream(destPath);  
                    document.write(outStream);  
                    outStream.close();  
                    return true;  
                } catch (FileNotFoundException e) {  
                    e.printStackTrace();  
                    return false;  
                } catch (IOException e) {  
                    e.printStackTrace();  
                    return false;  
                }  
            } else {  
                return false;  
            }  
        } else {  
            return false;  
        }  
    }  
    
    /**
     * 根据模板doc 替换字段后供用户下载
     * @param srcPath 模板地址
     * @param map 替换模板对应数据map
     * @param responseStream response流
     * @return
     */
    public static boolean replaceAndDownloadWord(String srcPath,  
             Map<String, String> map,OutputStream responseStream) {  
        String[] sp = srcPath.split("\\.");  
        if ((sp.length > 0)) {// 判断文件有无扩展名  
            // 比较文件扩展名  
            if (sp[sp.length - 1].equalsIgnoreCase("docx")) {  
                try {  
                    XWPFDocument document = new XWPFDocument(  
                            POIXMLDocument.openPackage(srcPath));  
                    // 替换段落中的指定文字  
                    Iterator<XWPFParagraph> itPara = document  
                            .getParagraphsIterator();  
                    while (itPara.hasNext()) {  
                        XWPFParagraph paragraph = (XWPFParagraph) itPara.next();  
                        List<XWPFRun> runs = paragraph.getRuns();  
                        for (int i = 0; i < runs.size(); i++) {  
                            String oneparaString = runs.get(i).getText(  
                                    runs.get(i).getTextPosition());  
                            for (Map.Entry<String, String> entry : map  
                                    .entrySet()) {  
                                oneparaString = oneparaString.replace(  
                                        entry.getKey(), entry.getValue());  
                            }  
                            runs.get(i).setText(oneparaString, 0);  
                        }  
                    }  
  
                    // 替换表格中的指定文字  
                    Iterator<XWPFTable> itTable = document.getTablesIterator();  
                    while (itTable.hasNext()) {  
                        XWPFTable table = (XWPFTable) itTable.next();  
                        int rcount = table.getNumberOfRows();  
                        for (int i = 0; i < rcount; i++) {  
                            XWPFTableRow row = table.getRow(i);  
                            List<XWPFTableCell> cells = row.getTableCells();  
                            for (XWPFTableCell cell : cells) {  
                                String cellTextString = cell.getText();  
                                for (Entry<String, String> e : map.entrySet()) {  
                                    if (cellTextString.contains(e.getKey()))  
                                        cellTextString = cellTextString  
                                                .replace(e.getKey(),  
                                                        e.getValue());  
                                }  
                                cell.removeParagraph(0);  
                                cell.setText(cellTextString);  
                            }  
                        }  
                    }  
                    
                    document.write(responseStream);  
                    
                   /* FileOutputStream outStream = null;  
                    outStream = new FileOutputStream(destPath);  
                    document.write(outStream);  
                    outStream.close();  */
                    return true;  
                } catch (Exception e) {  
                    e.printStackTrace();  
                    return false;  
                }  
  
            } else  
            // doc只能生成doc，如果生成docx会出错  
            if ((sp[sp.length - 1].equalsIgnoreCase("doc"))) {  
                HWPFDocument document = null;  
                try {  
                    document = new HWPFDocument(new FileInputStream(srcPath));  
                    Range range = document.getRange();  
                    for (Map.Entry<String, String> entry : map.entrySet()) {  
                        range.replaceText(entry.getKey(), entry.getValue().replaceAll("\r\n", ""+(char)11));  
                    }  
                    document.write(responseStream);
                    /*FileOutputStream outStream = null;  
                    outStream = new FileOutputStream(destPath);  
                    document.write(outStream);  
                    outStream.close();  */
                    return true;  
                } catch (FileNotFoundException e) {  
                    e.printStackTrace();  
                    return false;  
                } catch (IOException e) {  
                    e.printStackTrace();  
                    return false;  
                }  
            } else {  
                return false;  
            }  
        } else {  
            return false;  
        }  
    }
  
   /* public static void main(String[] args) {  
        // TODO Auto-generated method stub  
        String filepathString = "E:/ceshi.doc"; //模板地址
        String destpathString = "E:/success.doc"; //生成文档地址  
        Map<String, String> map = new HashMap<String, String>();  
        map.put("${TITLE}", "测试标题");  
        map.put("${NAME}", "王五");  
        map.put("${AGE}", "23");  
        map.put("${SEX}", "男");  
        map.put("${TYPE}", "学生");  
        map.put("${ADDRESS}", "陕西省西安市");  
        map.put("${PHONE}", "13589654785"); 
        map.put("${TEST}", "13589654785"); 
        System.out.println(replaceAndGenerateWord(filepathString,  
                destpathString, map));  
    }*/  
}