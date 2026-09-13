function createPictureFromURL(url)
    local http = getInternet()
    local file = http.getURL(url)
    http.destroy()
    local picture = createPicture()
    local stream = createStringStream(file)
    picture.loadFromStream(stream)
    return picture
end
local function getPictureSize(pic)
    local bmp = pic.Bitmap
    if bmp and bmp.Width and bmp.Height then
        return bmp.Width, bmp.Height
    end
    local g = pic.Graphic
    if g and g.Width and g.Height then
        return g.Width, g.Height
    end
    return nil, nil
end
if form then form.destroy() form = nil end
ImgURL = inputQuery("Please Input(请输入)","Image URL(图片的链接)","")
local pic = createPictureFromURL(ImgURL)
local imgW, imgH = getPictureSize(pic)
local screenW = getScreenWidth()
local screenH = getScreenHeight()
local maxW = math.floor(screenW * 0.9)
local maxH = math.floor(screenH * 0.9)
local dispW, dispH = imgW, imgH
if dispW > maxW or dispH > maxH then
    local scale = math.min(maxW / imgW, maxH / imgH)
    dispW = math.floor(imgW * scale)
    dispH = math.floor(imgH * scale)
end
form = createForm()
form.Width  = dispW
form.Height = dispH
form.Popupmode = 0
form.Position = poDesktopCenter
form.Caption = 'Image resolution(图片分辨率):' .. string.format('%dx%d', imgW, imgH)
local FrmImg1 = createImage(form)
FrmImg1.Left   = 0
FrmImg1.Top    = 0
FrmImg1.Width  = dispW
FrmImg1.Height = dispH
FrmImg1.Picture = pic
FrmImg1.Stretch = true
FrmImg1.Proportional = true
FrmImg1.Center = true