library;

class NeonFonts {
  const NeonFonts._();

  static const String fontFaces = '''
/* Akzidenz-GroteskPro - Body Font */
@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_regular.ttf') format('truetype');
  font-weight: 400;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_it.ttf') format('truetype');
  font-weight: 400;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_md.ttf') format('truetype');
  font-weight: 500;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_bold.ttf') format('truetype');
  font-weight: 700;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_boldit.ttf') format('truetype');
  font-weight: 700;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_xbd.ttf') format('truetype');
  font-weight: 800;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/assets/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_light.ttf') format('truetype');
  font-weight: 300;
  font-style: normal;
  font-display: block;
}

/* Hack - Monospace Font */
@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/hack/Hack-Regular.ttf') format('truetype');
  font-weight: 400;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/hack/Hack-Italic.ttf') format('truetype');
  font-weight: 400;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/hack/Hack-Bold.ttf') format('truetype');
  font-weight: 700;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'Hack';
  src: url('/assets/fonts/hack/Hack-BoldItalic.ttf') format('truetype');
  font-weight: 700;
  font-style: italic;
  font-display: block;
}

/* ITCAvantGardeStd - Heading Font */
@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLt.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLt.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLt.ttf') format('truetype');
  font-weight: 200;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLtObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLtObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-XLtObl.ttf') format('truetype');
  font-weight: 200;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bk.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bk.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bk.ttf') format('truetype');
  font-weight: 400;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BkObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BkObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BkObl.ttf') format('truetype');
  font-weight: 400;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Md.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Md.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Md.ttf') format('truetype');
  font-weight: 500;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-MdObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-MdObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-MdObl.ttf') format('truetype');
  font-weight: 500;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Demi.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Demi.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Demi.ttf') format('truetype');
  font-weight: 600;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-DemiObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-DemiObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-DemiObl.ttf') format('truetype');
  font-weight: 600;
  font-style: italic;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bold.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bold.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bold.ttf') format('truetype');
  font-weight: 700;
  font-style: normal;
  font-display: block;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BoldObl.woff2') format('woff2'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BoldObl.woff') format('woff'),
       url('/assets/fonts/ITCAvantGardeStd/ITCAvantGardeStd-BoldObl.ttf') format('truetype');
  font-weight: 700;
  font-style: italic;
  font-display: block;
}
''';
}
