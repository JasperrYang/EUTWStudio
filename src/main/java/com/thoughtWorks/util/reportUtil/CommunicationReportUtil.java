package com.thoughtWorks.util.reportUtil;

import com.thoughtWorks.util.excelUtil.ExcelReportUtil;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.util.CellRangeAddress;

import java.util.List;
import java.util.Map;

public class CommunicationReportUtil extends ExcelReportUtil {
    @Override
    protected void writeHeaders(HSSFSheet sheet, Map<String, String> headers) {
        HSSFRow row = sheet.createRow(1);

        String[] keys = {"index", "teacher", "type", "level1", "level2", "level3"};
        int columnIndex = 0;
        for (String key : keys) {
            HSSFCell cell = row.createCell(columnIndex++);
            cell.setCellValue(new HSSFRichTextString(headers.get(key)));
        }
    }

    @Override
    protected void writeCellData(HSSFSheet sheet, List<Map<String, Object>> dataset, HSSFWorkbook workbook) {
        try {
            sheet.setColumnWidth((short) 1, (short) 5000);
            sheet.setColumnWidth((short) 2, (short) 4500);

            int rowIndex = 2;
            int totalCount = 0;
            for (int i = 0; i < dataset.size(); ++i) {
                int littleCount = 0;
                Map<String, Object> teacher = dataset.get(i);
                List<Map<String, Object>> types = (List<Map<String, Object>>) teacher.get("type");
                if (types.size() >= 2)
                    sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex + types.size() - 1, 1, 1));

                for (int j = 0; j < types.size(); ++j) {
                    HSSFRow row = sheet.createRow(rowIndex++);
                    HSSFCell cell =  setSerialNumber(rowIndex, row);
                    //系
                    cell = row.createCell(1);
                    cell.setCellValue(new HSSFRichTextString(teacher.get("teacher").toString()));
                    CellStyle cellStyle = createCellStyle();
                    setAlignmentCenter(cellStyle, cell);
                    //就业方向
                    cell = row.createCell(2);
                    cell.setCellValue(new HSSFRichTextString(types.get(j).get("type").toString()));

                    //levels
                    int levelIndex = 3;
                    List<Map<String, Integer>> levels = (List<Map<String, Integer>>) types.get(j).get("levels");
                    for (Map<String, Integer> level : levels) {
                        cell = row.createCell(levelIndex++);
                        cell.setCellValue(new HSSFRichTextString(Integer.toString(level.get("count"))));
                        littleCount += level.get("count");
                    }
                }
                //小计
                HSSFRow row = sheet.createRow(rowIndex++);
                //序号
                HSSFCell cell = setSerialNumber(rowIndex, row);
                cell = row.createCell(1);
                cell.setCellValue(new HSSFRichTextString("小计"));
                cell = row.createCell(2);
                cell.setCellValue(new HSSFRichTextString(String.valueOf(littleCount)));
                totalCount+=littleCount;
            }
            //总计
            HSSFRow row = sheet.createRow(rowIndex++);
            //序号
            HSSFCell cell = setSerialNumber(rowIndex, row);
            cell = row.createCell(1);
            cell.setCellValue(new HSSFRichTextString("总计"));
            cell = row.createCell(2);
            cell.setCellValue(new HSSFRichTextString(String.valueOf(totalCount)));

            setDefaultRowHeight(sheet, 20);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private HSSFCell setSerialNumber(int rowIndex, HSSFRow row) {
        //序号
        HSSFCell cell = row.createCell(0);
        cell.setCellValue(new HSSFRichTextString(String.valueOf(rowIndex - 2)));

        return cell;
    }
}
