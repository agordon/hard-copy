## Hard-Copy - Encoding/Decoding Examples

The files in this directory are examples of encoding/decoding files using **hard-copy**.

### Encoding

The file `encoding/example` is an SSH RSA private key. It was created using:

    ssh-keygen -t rsa -f example

The file `encoding/example.pdf` is a hard-copy PDF generated with:

    hard-copy.sh -c example

(The `-c` option tells `hard-copy.sh` not to encrypt the file, for the purpose
of this demo).

### Decoding (High-Quality, Clean QR-Codes)

Using [QR-Codes](http://www.qrcode.com), restoring the data should be easy.
This of course depends on how clear the QR-Codes are on the page (how well the
printed paper was preserved).

The file `decoding/clean.jpg` is an example of a scanned PDF output (i.e. the PDF
was printed, then the document was scanned using an office scanner, with 300 DPI
resolution).

Extracting the encoded text from the clean scan is quick and easy:

    $ zbarimg -q --raw example/decoding/clean.jpg

The output matches the BASE64 encoded information in the PDF:

```
031 1VZkF 6TU1D Z1lFQ XFrWn ExZnl PclB0 dHJjU 2lvMV k2OWh tOGpj ZTYzd DZOdT VNU0R 
032 iWDlQ b1AwQ WFzYV RPeXI KM0VH dkZSV XFIV1 puM3p OaG85 ZUMvM Wp0TW pJSWF 5QWkr 
033 ZTV2b 1NpTV ZjeHd DTWpI ZERUO UgrSH cySWR 4OWky YQpzd DF0M2 Z1Uk9 XVmJX eUZDZ 
034 GJnZD I4M0Q xbE51 TSt6R lFtQU FoZ3F LcXRm MnQyW GFISU p1OXZ NPQot LS0tL UVORC 
035 BSU0E gUFJJ VkFUR SBLRV ktLS0 tLQo= 

013 L0ZlU XNGUn Vldlh CK2pT cHA0W GxDZm NsTGF ZZERZ VwpXS StUam Z5Qys veThn RTVna 
014 W56eX J0alh 4MDlE S1FlU UdTZk lWbkF hR25J T3hwU nhOSV E1RWN zQXlr K3lXQ 3I2Cn 
015 RrRk1 hdjBj QzJJa URrNT g3RHZ jOXg5 bUJZU nNobG JUdDV rZTE1 QkV4Z 3p6Qm 1oY1d 
016 iS0x0 Rlhqc HhhN3 VNcHY KaXBB cDN3R UNnWU VBMW5 lalFJ ZmJFb jZhMm dacGU 3Mmtv 
017 eHVlO ExmS3 dURE5 aWTRk VmZIa VdYan czbGR 3OEZw NAp6e G03MF lvMDA yQTMz L0tCT 
018 EI5ZT hNUXU vWURY VFJob mg4YW tMaG5 ZbU1T ZFJ2e Tdpal FoZ3l ZZFdi ckUzN 0xVCj 

007 9hVmd SV1la bXozR Dh4dW t2M0o 1cm40 MlVXU HZGbF N3a0h JZFRN MjFRS U9ITU M2L2Q 
008 wcjV0 ZWFLZ zl0Um FXNmc KNTZS UCtsR HNZZj REVld ZdjM1 Qi82U 1VFRj FMcno 3N2ZG 
009 cVROT HdJRE FRQUJ Bb0lC QURMU G5KM0 dNMGN 6V2Fv YQpTU U1pay tkcVN 6QVBD UXNza 
010 zNRUE phRjd BL3px UmtyT mpuVl BPWGF 4eDBi dkhrc DRKaC t4Skh oeExT bXdoR lhBCm 
011 dZaHh QckVT dCtXS k9Rbk J1TVp 5ZzRC Rit1b WRMUW 5ZS1Z xbXhQ cGFLR WNKKy 8yV29 
012 sSk5N WG5pM 3FCai 9hS1U KL3dC eFFMb FplT0 FBZU1 6Nlh5 QVQ0U jFjWX lQSE0 3c01l 

025 aUdUS zMren VVc0d LK2NO K0VQM HhXVD RjejQ wSlho cApVU 0QwTW hCZzh nTEsy OVhYS 
026 WZHS3 RCTGl QQWg5 Q3Nyd zRwRk cwMmx EcjhZ OGdFR zdCZV FEOFV aaWph cHFwO StjCl 
027 FpMmx vYXZh eE1ZS GhCRl l5WXR abSsw Q2dZR UF6K2 5pRHh sNG4w aHlMM zhPbW 80RXB 
028 NTlJF YTVBV kVxZV JnWU8 KNzhY Q1o2Y mYzZ2 9ZL0c vQ1pL UVBBW HJtRW 1UY2J rbTdr 
029 UUhiU U5PWl BWaVp SNnpY cm5Ub HRrbG 9MaVQ 4Y0Zy VApLR 3lHd3 dySjJ tTXBW MWExb 
030 FE4UT MwVnE 4VnJo Q3l1T kVsTz RZZit 6TFdK Ymw0a Utabk huUXR ZUDJl b3Qrd nhUCk 

001 LS0tL S1CRU dJTiB SU0Eg UFJJV kFURS BLRVk tLS0t LQpNS UlFcF FJQkF BS0NB UUVBc 
002 2VKME podzl jcjVl N1FTa k1TdW pYUyt FRkgw UHJMW jJtYU swRlh PYVhX ZkJ0Z URXCm 
003 QyOWF xbUgv Qm03S k5pSH NNalN SMnFs dU5Pc 3Z5Tz JBVjF jdWF3 T2Zud DNZMy 91b2x 
004 5RDA0 UTlBR 3BYNH FCeTA KL1No Qk9BQ jVPOE 9tMU8 1K2x5 L0FOT XFDYz VCaUh TTUh1 
005 NFNjW HVHZD R3Ym5 QWWJ5 eTc5Q UlGbE hWUXN 0ck9X YwpxT TNCbE x3RlR BTm0x aTJhT 
006 2gwTH lyeWF 0WVFW N0oxY jdzSG d3dGx hdDFL Ykpke HJwdn IyLzl RY2Rs QUdwS 3lDCi 

019 RuRWt zTms0 RkF4N Tgxa1 JwL3l 1c2pJ NTFMQ lZ0bk E1Nkt JMnQr VVhnS zMvZ1 dTU1Z 
020 BeHVZ KzBDZ 1lFQT FGVXo KbXJ4 Z3I0Z WdrK1 NvaHV MSXBR N0RiN G91dV UrVlN IVWNm 
021 SCtOU 3Ezal ZrNTY zcmlQ ZUVQR WRJST Q0aWN Fa0hN LwpkW nlkR3 labml qYTM5 YmRlc 
022 UVhRG 1kdEk vU2tN SU9xR UlMbn RHTzF FSndq WHo0W HpHUk 1tNW5 OQjNu bFNWM 1E0Ck 
023 JCNjZ UNjVT VFViN TNqNW 9NOGY vaWtx ZDl3U XpRaE 1aNEd DVVNn c0NnW UVBcV RxVUR 
024 mcGxh ZzJPb 1JWSU xNVHk KNFdX TklBT FdzV1 NSM2w ycVZr UGNTS jkrNk 9MMGt pUEJp 
```

NOTE: The order of the lines (based on the order of the decoded QR-Codes) does not matter,
as they will be sorted before decoding.

Every PDF file produced by **hard-copy** contains detailed instructions on how to
decode the information using the QR-Codes, and how to correct errors (if any).

With clean, high-quality QR-Codes, the decoding process is simple:
```sh
$ zbarimg -q --raw example/decoding/clean.jpg | \
        grep -v '^$' | sort -k1n,1 | cut -c4- | \
        tr -d ' ' | base64 -d > key
$ cat key
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAseJ0Jhw9cr5e7QSjMSujXS+EFH0PrLZ2maK0FXOaXWfBteDW
d29aqmH/Bm7JNiHsMjSR2qluNOsvyO2AV1cuawOfnt3Y3/uolyD04Q9AGpX4qBy0
/ShBOAB5O8Om1O5+ly/ANMqCc5BiHSMHu4ScXuGd4wbnPYbyy79AIFlHVQstrOWc
qM3BlLwFTANm1i2aOh0LyryatYQV7J1b7sHgwtlat1KbJdxrpvr2/9QcdlAGpKyC
/aVgRWYZmz3D8xukv3J5rn42UWPvFlSwkHIdTM21QIOHMC6/d0r5teaKg9tRaW6g
56RP+lDsYf4DVWYv35B/6SUEF1Lrz77fFqTNLwIDAQABAoIBADLPnJ3GM0czWaoa
SQMik+dqSzAPCQssk3QPJaF7A/zqRkrNjnVPOXaxx0bvHkp4Jh+xJHhxLSmwhFXA
gYhxPrESt+WJOQnBuMZyg4BF+umdLQnYKVqmxPpaKEcJ+/2WolJNMXni3qBj/aKU
/wBxQLlZeOAAeMz6XyAT4R1cYyPHM7sMe/FeQsFRuevXB+jSpp4XlCfclLaYdDYW
WI+TjfyC+/y8gE5ginzyrtjXx09DKQeQGSfIVnAaGnIOxpRxNIQ5EcsAyk+yWCr6
tkFMav0cC2IiDk587Dvc9x9mBYRshlbTt5ke15BExgzzBmhcWbKLtFXjpxa7uMpv
ipAp3wECgYEA1nejQIfbEn6a2gZpe72koxue8LfKwTDNZY4dVfHiWXjw3ldw8Fp4
zxm70Yo002A33/KBLB9e8MQu/YDXTRhnh8akLhnYmMSdRvy7ijQhgyYdWbrE37LU
4nEksNk4FAx581kRp/yusjI51LBVtnA56KI2t+UXgK3/gWSSVAxuY+0CgYEA1FUz
mrxgr4egk+SohuLIpQ7Db4ouuU+VSHUcfH+NSq3jVk563riPeEPEdII44icEkHM/
dZydGyZnija39bdeqEaDmdtI/SkMIOqEILntGO1EJwjXz4XzGRMm5nNB3nlSV3Q4
BB66T65STUb53j5oM8f/ikqd9wQzQhMZ4GCUSgsCgYEAqTqUDfplag2OoRVILMTy
4WWNIALWsWSR3l2qVkPcSJ9+6OL0kiPBiiGTK3+zuUsGK+cN+EP0xWT4cz40JXhp
USD0MhBg8gLK29XXIfGKtBLiPAh9Csrw4pFG02lDr8Y8gEG7BeQD8UZijapqp9+c
Qi2loavaxMYHhBFYyYtZm+0CgYEAz+niDxl4n0hyL38Omo4EpMNREa5AVEqeRgYO
78XCZ6bf3goY/G/CZKQPAXrmEmTcbkm7kQHbQNOZPViZR6zXrnTltkloLiT8cFrT
KGyGwwrJ2mMpV1a1lQ8Q30Vq8VrhCyuNElO4Yf+zLWJbl4iKZnHnQtYP2eot+vxT
MUfAzMMCgYEAqkZq1fyOrPttrcSio1Y69hm8jce63t6Nu5MSDbX9PoP0AasaTOyr
3EGvFRUqHWZn3zNho9eC/1jtMjIIayAi+e5voSiMVcxwCMjHdDT9H+Hw2Idx9i2a
st1t3fuROWVbWyFCdbgd283D1lNuM+zFQmAAhgqKqtf2t2XaHIJu9vM=
-----END RSA PRIVATE KEY-----
```

### Decoding (Messy QR-Codes)

The file `example/decoding/messy.jpg` contains a scanned document, where the
hard-copy paper is messy:

1. QR-Code #1 was crimpled, then straightened
2. QR-Code #2 was torn, then taped
3. QR-Code #3 was folded, then un-folded
4. QR-Code #4 was not modified
5. QR-Code #5 was drawn over with a black pen
6. QR-Code $6 was drawn over with a blue felt-tip pen.

Trying to decode `messy.jpg` directly restores only 3 out of the 6 QR-Codes.

One method to improve decoding is to save each QR-Code in its own image.
Using 'GIMP', the process is relatively quick:

1. Load scanned image with multiple QR-Codes
2. Press CTRL+R (Selection tool)
3. Mark a rectangle around one QR-Code image
4. Press CTRL+C (Copy)
5. Press CTRL+Shift+V (Create new image from Clipboard)
6. Press CTRL+e (Export)
7. Type filename and ".jpg", press ENTER
8. Press TAB, enter JPG Quality (85 is sufficient), press TAB, ENTER to save.
9. Repeat steps 2-8 for each of the QR-Codes.

The resulting cropped images ( `messy_cropped_001.jpg` to `messy_cropped_006.jpg` )
are in the `examples/decoding` directory.

Using `zbarimg` we're able to decode four of the six images:

```sh
$ for i in example/decoding/messy_cropped_00?.jpg ; do
     zbarimg -q --raw "$i" 1>/dev/null 2>/dev/null && echo $i - OK  || echo $i - failed
  done
example/decoding/messy_cropped_001.jpg - OK
example/decoding/messy_cropped_002.jpg - OK
example/decoding/messy_cropped_003.jpg - OK
example/decoding/messy_cropped_004.jpg - OK
example/decoding/messy_cropped_005.jpg - failed
example/decoding/messy_cropped_006.jpg - failed
```

QR-Codes #5 and #6 failed:

```sh
$ zbarimg 006.jpg
scanned 0 barcode symbols from 1 images in 0.2 seconds


WARNING: barcode data was not detected in some image(s)
  things to check:
    - is the barcode type supported?  currently supported symbologies are:
      EAN/UPC (EAN-13, EAN-8, UPC-A, UPC-E, ISBN-10, ISBN-13),
      Code 128, Code 39 and Interleaved 2 of 5
    - is the barcode large enough in the image?
    - is the barcode mostly in focus?
    - is there sufficient contrast/illumination?
```

Using `convert` (an *ImageMagick* program) we can convert the failed images
to black-and-white and apply a threshold, trying to remove noisy data:

```sh
$ convert 005.jpg -threshold 20% 005_threshold.png
$ convert 006.jpg -threshold 20% 006_threshold.png
```

After cleaning-up the images, `zbarimg` is able to decode the QR-Codes:

```sh
$ zbarimg 006_threshold.png
QR-Code:031 1VZkF 6TU1D Z1lFQ XFrWn ExZnl PclB0 dHJjU 2lvMV k2OWh tOGpj ZTYzd DZOdT VNU0R
032 iWDlQ b1AwQ WFzYV RPeXI KM0VH dkZSV XFIV1 puM3p OaG85 ZUMvM Wp0TW pJSWF 5QWkr
033 ZTV2b 1NpTV ZjeHd DTWpI ZERUO UgrSH cySWR 4OWky YQpzd DF0M2 Z1Uk9 XVmJX eUZDZ
034 GJnZD I4M0Q xbE51 TSt6R lFtQU FoZ3F LcXRm MnQyW GFISU p1OXZ NPQot LS0tL UVORC
035 BSU0E gUFJJ VkFUR SBLRV ktLS0 tLQo=

scanned 1 barcode symbols from 1 images in 0.19 seconds
```

Once the images are properly decoded, we can use the previous method to restore
the key:

```sh
$ zbarimg -q --raw example/decoding/messy_cropped_00{1,2,3,4}.jpg \
                example/decoding/messy_cropped_00*.png | \
        grep -v '^$' | sort -k1n,1 | cut -c4- | \
        tr -d ' ' | base64 -d > key
$ cat key
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAseJ0Jhw9cr5e7QSjMSujXS+EFH0PrLZ2maK0FXOaXWfBteDW
d29aqmH/Bm7JNiHsMjSR2qluNOsvyO2AV1cuawOfnt3Y3/uolyD04Q9AGpX4qBy0
/ShBOAB5O8Om1O5+ly/ANMqCc5BiHSMHu4ScXuGd4wbnPYbyy79AIFlHVQstrOWc
qM3BlLwFTANm1i2aOh0LyryatYQV7J1b7sHgwtlat1KbJdxrpvr2/9QcdlAGpKyC
/aVgRWYZmz3D8xukv3J5rn42UWPvFlSwkHIdTM21QIOHMC6/d0r5teaKg9tRaW6g
56RP+lDsYf4DVWYv35B/6SUEF1Lrz77fFqTNLwIDAQABAoIBADLPnJ3GM0czWaoa
SQMik+dqSzAPCQssk3QPJaF7A/zqRkrNjnVPOXaxx0bvHkp4Jh+xJHhxLSmwhFXA
gYhxPrESt+WJOQnBuMZyg4BF+umdLQnYKVqmxPpaKEcJ+/2WolJNMXni3qBj/aKU
/wBxQLlZeOAAeMz6XyAT4R1cYyPHM7sMe/FeQsFRuevXB+jSpp4XlCfclLaYdDYW
WI+TjfyC+/y8gE5ginzyrtjXx09DKQeQGSfIVnAaGnIOxpRxNIQ5EcsAyk+yWCr6
tkFMav0cC2IiDk587Dvc9x9mBYRshlbTt5ke15BExgzzBmhcWbKLtFXjpxa7uMpv
ipAp3wECgYEA1nejQIfbEn6a2gZpe72koxue8LfKwTDNZY4dVfHiWXjw3ldw8Fp4
zxm70Yo002A33/KBLB9e8MQu/YDXTRhnh8akLhnYmMSdRvy7ijQhgyYdWbrE37LU
4nEksNk4FAx581kRp/yusjI51LBVtnA56KI2t+UXgK3/gWSSVAxuY+0CgYEA1FUz
mrxgr4egk+SohuLIpQ7Db4ouuU+VSHUcfH+NSq3jVk563riPeEPEdII44icEkHM/
dZydGyZnija39bdeqEaDmdtI/SkMIOqEILntGO1EJwjXz4XzGRMm5nNB3nlSV3Q4
BB66T65STUb53j5oM8f/ikqd9wQzQhMZ4GCUSgsCgYEAqTqUDfplag2OoRVILMTy
4WWNIALWsWSR3l2qVkPcSJ9+6OL0kiPBiiGTK3+zuUsGK+cN+EP0xWT4cz40JXhp
USD0MhBg8gLK29XXIfGKtBLiPAh9Csrw4pFG02lDr8Y8gEG7BeQD8UZijapqp9+c
Qi2loavaxMYHhBFYyYtZm+0CgYEAz+niDxl4n0hyL38Omo4EpMNREa5AVEqeRgYO
78XCZ6bf3goY/G/CZKQPAXrmEmTcbkm7kQHbQNOZPViZR6zXrnTltkloLiT8cFrT
KGyGwwrJ2mMpV1a1lQ8Q30Vq8VrhCyuNElO4Yf+zLWJbl4iKZnHnQtYP2eot+vxT
MUfAzMMCgYEAqkZq1fyOrPttrcSio1Y69hm8jce63t6Nu5MSDbX9PoP0AasaTOyr
3EGvFRUqHWZn3zNho9eC/1jtMjIIayAi+e5voSiMVcxwCMjHdDT9H+Hw2Idx9i2a
st1t3fuROWVbWyFCdbgd283D1lNuM+zFQmAAhgqKqtf2t2XaHIJu9vM=
-----END RSA PRIVATE KEY-----
```


### Decoding (Poor-Quality QR-Codes)

There are several free mobile phone applications which can decode QR-Codes,
even of poor-quality. Use these applications, and copy&paste the decode information
into one text file, then proceed as before.

### Decoding (Failed QR-Codes)

If some of the QR-Codes can not be decoded, save the decoded information from 
the other QR-Codes, the use the Base64 infomration in the PDF file to correct
wrong lines and complete missing lines. The BASE64 information in the PDF file
is specifically formatted for easy usage, with per-line checksum.
