package sic.sim.views;

import sic.common.Conversion;
import sic.common.SICXE;
import sic.sim.Executor;

import javax.swing.*;
import javax.swing.border.TitledBorder;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * TODO: write a short description
 *
 * @author jure
 */
public class MemoryView {

    private JButton btnUpUpUp;
    private JButton btnUpUp;
    private JButton btnUp;
    private JButton btnDn;
    private JButton btnDnDn;
    private JButton btnDnDnDn;
    private HexEdit hex;
    private JTextField txtLocation;
    private JTextField txtCursor;
    public JPanel mainPanel;

    public MemoryView(final Executor executor) {
        hex.setMachine(executor.getMachine());
        btnUpUpUp.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                hex.moveStartAddress(-HexEdit.MOVE_MEM_LARGE);
                hex.requestFocus();
                updateView();
            }
        });
        btnUpUp.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                hex.moveStartAddress(-HexEdit.MOVE_MEM_MEDIUM);
                hex.requestFocus();
                updateView();
            }
        });
        btnUp.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                hex.moveStartAddress(-HexEdit.MOVE_MEM_SMALL);
                hex.requestFocus();
                updateView();
            }
        });
        btnDn.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                hex.moveStartAddress(HexEdit.MOVE_MEM_SMALL);
                hex.requestFocus();
                updateView();
            }
        });
        btnDnDn.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                hex.moveStartAddress(HexEdit.MOVE_MEM_MEDIUM);
                hex.requestFocus();
                updateView();
            }
        });
        btnDnDnDn.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                hex.moveStartAddress(HexEdit.MOVE_MEM_LARGE);
                hex.requestFocus();
                updateView();
            }
        });
        txtLocation.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                hex.setStartAddress(SICXE.intToAddr(Conversion.hexToInt(txtLocation.getText())));
                hex.requestFocus();
                updateView();
            }
        });
        hex.onAddressChange = new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                updateView();
            }
        };
    }

    public void updateView() {
        txtLocation.setText(Conversion.addrToHex(hex.getStartAddress()));
        txtCursor.setText(Conversion.addrToHex(hex.getCursorAddress()));
        hex.repaint();
    }

    {
// GUI initializer generated by IntelliJ IDEA GUI Designer
// >>> IMPORTANT!! <<<
// DO NOT EDIT OR ADD ANY CODE HERE!
        $$$setupUI$$$();
    }

    /**
     * Method generated by IntelliJ IDEA GUI Designer
     * >>> IMPORTANT!! <<<
     * DO NOT edit this method OR call it in your code!
     *
     * @noinspection ALL
     */
    private void $$$setupUI$$$() {
        mainPanel = new JPanel();
        mainPanel.setLayout(new BorderLayout(0, 0));
        mainPanel.setBorder(BorderFactory.createTitledBorder(BorderFactory.createLoweredBevelBorder(), "Memory", TitledBorder.DEFAULT_JUSTIFICATION, TitledBorder.DEFAULT_POSITION, null, null));
        final JPanel panel1 = new JPanel();
        panel1.setLayout(new FlowLayout(FlowLayout.CENTER, 5, 5));
        mainPanel.add(panel1, BorderLayout.SOUTH);
        btnUpUpUp = new JButton();
        btnUpUpUp.setPreferredSize(new Dimension(60, 29));
        btnUpUpUp.setText("<<<");
        panel1.add(btnUpUpUp);
        btnUpUp = new JButton();
        btnUpUp.setPreferredSize(new Dimension(60, 29));
        btnUpUp.setText("<<");
        panel1.add(btnUpUp);
        btnUp = new JButton();
        btnUp.setPreferredSize(new Dimension(60, 29));
        btnUp.setText("<");
        panel1.add(btnUp);
        txtLocation = new JTextField();
        txtLocation.setColumns(4);
        txtLocation.setText("00000");
        panel1.add(txtLocation);
        txtCursor = new JTextField();
        txtCursor.setColumns(4);
        txtCursor.setText("00000");
        panel1.add(txtCursor);
        btnDn = new JButton();
        btnDn.setPreferredSize(new Dimension(60, 29));
        btnDn.setText(">");
        panel1.add(btnDn);
        btnDnDn = new JButton();
        btnDnDn.setPreferredSize(new Dimension(60, 29));
        btnDnDn.setText(">>");
        panel1.add(btnDnDn);
        btnDnDnDn = new JButton();
        btnDnDnDn.setPreferredSize(new Dimension(60, 29));
        btnDnDnDn.setText(">>>");
        panel1.add(btnDnDnDn);
        hex = new HexEdit();
        Font hexFont = this.$$$getFont$$$("Lucida Console", -1, -1, hex.getFont());
        if (hexFont != null) hex.setFont(hexFont);
        mainPanel.add(hex, BorderLayout.CENTER);
    }

    /**
     * @noinspection ALL
     */
    private Font $$$getFont$$$(String fontName, int style, int size, Font currentFont) {
        if (currentFont == null) return null;
        String resultName;
        if (fontName == null) {
            resultName = currentFont.getName();
        } else {
            Font testFont = new Font(fontName, Font.PLAIN, 10);
            if (testFont.canDisplay('a') && testFont.canDisplay('1')) {
                resultName = fontName;
            } else {
                resultName = currentFont.getName();
            }
        }
        return new Font(resultName, style >= 0 ? style : currentFont.getStyle(), size >= 0 ? size : currentFont.getSize());
    }

    /**
     * @noinspection ALL
     */
    public JComponent $$$getRootComponent$$$() {
        return mainPanel;
    }

}
