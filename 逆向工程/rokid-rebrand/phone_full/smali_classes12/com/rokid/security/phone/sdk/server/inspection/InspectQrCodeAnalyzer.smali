.class public final Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;
.super Ljava/lang/Object;
.source "InspectQrCodeAnalyzer.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nInspectQrCodeAnalyzer.kt\nKotlin\n*S Kotlin\n*F\n+ 1 InspectQrCodeAnalyzer.kt\ncom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,137:1\n1#2:138\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000d\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0012\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008\u00c7\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0014\u001a\u00020\u00152\u0006\u0010\u0016\u001a\u00020\u0007J\u000e\u0010\u0017\u001a\u00020\u00152\u0006\u0010\u0016\u001a\u00020\u0007J*\u0010\u0018\u001a\u0004\u0018\u00010\u00192\u0006\u0010\u001a\u001a\u00020\u001b2\u0006\u0010\u001c\u001a\u00020\u001d2\u0006\u0010\u001e\u001a\u00020\u001d2\u0006\u0010\u001f\u001a\u00020\u001dH\u0002J@\u0010 \u001a\u00020\u00152\u0006\u0010\u001a\u001a\u00020\u001b2\u0006\u0010\u001c\u001a\u00020\u001d2\u0006\u0010\u001e\u001a\u00020\u001d2\u0008\u0008\u0002\u0010\u001f\u001a\u00020\u001d2\u0016\u0008\u0002\u0010!\u001a\u0010\u0012\u0006\u0012\u0004\u0018\u00010\u0004\u0012\u0004\u0012\u00020\u00150\"J\u0006\u0010#\u001a\u00020\u0015R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u0016\u0010\u0005\u001a\n\u0012\u0004\u0012\u00020\u0007\u0018\u00010\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0008\u001a\u0004\u0018\u00010\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\n\u001a\u0004\u0018\u00010\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\rX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000e\u001a\u00020\u000fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0010\u001a\u00020\u0011X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0012\u001a\u00020\u0013X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006$"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;",
        "",
        "()V",
        "TAG",
        "",
        "activityRef",
        "Ljava/lang/ref/WeakReference;",
        "Landroid/app/Activity;",
        "container",
        "Landroid/widget/FrameLayout;",
        "imageView",
        "Landroid/widget/ImageView;",
        "isBlocked",
        "",
        "lastPreviewTime",
        "",
        "options",
        "Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;",
        "scanner",
        "Lcom/google/mlkit/vision/barcode/BarcodeScanner;",
        "addTopRedImageView",
        "",
        "activity",
        "attach",
        "nv21ToBitmap",
        "Landroid/graphics/Bitmap;",
        "data",
        "",
        "width",
        "",
        "height",
        "rotation",
        "onNv21Data",
        "onResult",
        "Lkotlin/Function1;",
        "release",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;

.field private static final TAG:Ljava/lang/String; = "QrCodeAnalyzer"

.field private static activityRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/app/Activity;",
            ">;"
        }
    .end annotation
.end field

.field private static container:Landroid/widget/FrameLayout;

.field private static imageView:Landroid/widget/ImageView;

.field private static isBlocked:Z

.field private static lastPreviewTime:J

.field private static final options:Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

.field private static final scanner:Lcom/google/mlkit/vision/barcode/BarcodeScanner;


# direct methods
.method public static synthetic $r8$lambda$UjqWFmGrGSbtgIvaZLfzE4J5zpA(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->onNv21Data$lambda$1(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)V

    return-void
.end method

.method public static synthetic $r8$lambda$pmgP3kfijEDq02nC1vk1GLwDPqo(Lkotlin/jvm/functions/Function1;Ljava/lang/Exception;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->onNv21Data$lambda$2(Lkotlin/jvm/functions/Function1;Ljava/lang/Exception;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;

    .line 30
    nop

    .line 28
    new-instance v0, Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions$Builder;

    invoke-direct {v0}, Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions$Builder;-><init>()V

    .line 29
    const/4 v1, 0x0

    new-array v1, v1, [I

    const/16 v2, 0x100

    invoke-virtual {v0, v2, v1}, Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions$Builder;->setBarcodeFormats(I[I)Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions$Builder;

    move-result-object v0

    .line 30
    invoke-virtual {v0}, Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions$Builder;->build()Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

    move-result-object v0

    const-string v1, "Builder()\n        .setBa\u2026QR_CODE)\n        .build()"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->options:Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

    .line 31
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->options:Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

    invoke-static {v0}, Lcom/google/mlkit/vision/barcode/BarcodeScanning;->getClient(Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;)Lcom/google/mlkit/vision/barcode/BarcodeScanner;

    move-result-object v0

    const-string v1, "getClient(options)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->scanner:Lcom/google/mlkit/vision/barcode/BarcodeScanner;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$setBlocked$p(Z)V
    .locals 0
    .param p0, "<set-?>"    # Z

    .line 17
    sput-boolean p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->isBlocked:Z

    return-void
.end method

.method private final nv21ToBitmap([BIII)Landroid/graphics/Bitmap;
    .locals 15
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I
    .param p4, "rotation"    # I

    .line 108
    move/from16 v1, p4

    .line 109
    :try_start_0
    new-instance v0, Landroid/graphics/YuvImage;

    const/16 v4, 0x11

    const/4 v7, 0x0

    move-object v2, v0

    move-object/from16 v3, p1

    move/from16 v5, p2

    move/from16 v6, p3

    invoke-direct/range {v2 .. v7}, Landroid/graphics/YuvImage;-><init>([BIII[I)V

    .line 110
    .local v0, "yuv":Landroid/graphics/YuvImage;
    new-instance v2, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v2}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 111
    .local v2, "out":Ljava/io/ByteArrayOutputStream;
    new-instance v3, Landroid/graphics/Rect;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v4, 0x0

    move/from16 v5, p2

    move/from16 v6, p3

    :try_start_1
    invoke-direct {v3, v4, v4, v5, v6}, Landroid/graphics/Rect;-><init>(IIII)V

    move-object v7, v2

    check-cast v7, Ljava/io/OutputStream;

    const/16 v8, 0x55

    invoke-virtual {v0, v3, v8, v7}, Landroid/graphics/YuvImage;->compressToJpeg(Landroid/graphics/Rect;ILjava/io/OutputStream;)Z

    .line 112
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    .line 113
    .local v3, "bytes":[B
    array-length v7, v3

    invoke-static {v3, v4, v7}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object v8

    .line 115
    .local v8, "bmp":Landroid/graphics/Bitmap;
    if-eqz v1, :cond_0

    .line 116
    new-instance v13, Landroid/graphics/Matrix;

    invoke-direct {v13}, Landroid/graphics/Matrix;-><init>()V

    move-object v4, v13

    .line 138
    .local v4, "$this$nv21ToBitmap_u24lambda_u243":Landroid/graphics/Matrix;
    const/4 v7, 0x0

    .line 116
    .local v7, "$i$a$-apply-InspectQrCodeAnalyzer$nv21ToBitmap$matrix$1":I
    int-to-float v9, v1

    invoke-virtual {v4, v9}, Landroid/graphics/Matrix;->postRotate(F)Z

    .line 117
    .end local v4    # "$this$nv21ToBitmap_u24lambda_u243":Landroid/graphics/Matrix;
    .end local v7    # "$i$a$-apply-InspectQrCodeAnalyzer$nv21ToBitmap$matrix$1":I
    .local v13, "matrix":Landroid/graphics/Matrix;
    invoke-virtual {v8}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v11

    invoke-virtual {v8}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v12

    const/4 v14, 0x1

    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-static/range {v8 .. v14}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v4
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .end local v8    # "bmp":Landroid/graphics/Bitmap;
    .local v4, "bmp":Landroid/graphics/Bitmap;
    goto :goto_0

    .line 115
    .end local v4    # "bmp":Landroid/graphics/Bitmap;
    .end local v13    # "matrix":Landroid/graphics/Matrix;
    .restart local v8    # "bmp":Landroid/graphics/Bitmap;
    :cond_0
    move-object v4, v8

    .line 119
    .end local v8    # "bmp":Landroid/graphics/Bitmap;
    .restart local v4    # "bmp":Landroid/graphics/Bitmap;
    :goto_0
    nop

    .end local v0    # "yuv":Landroid/graphics/YuvImage;
    .end local v2    # "out":Ljava/io/ByteArrayOutputStream;
    .end local v3    # "bytes":[B
    .end local v4    # "bmp":Landroid/graphics/Bitmap;
    goto :goto_2

    .line 120
    :catch_0
    move-exception v0

    goto :goto_1

    :catch_1
    move-exception v0

    move/from16 v5, p2

    move/from16 v6, p3

    .line 121
    .local v0, "e":Ljava/lang/Exception;
    :goto_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "nv21ToBitmap \u51fa\u9519: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "QrCodeAnalyzer"

    invoke-static {v3, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 122
    const/4 v4, 0x0

    .line 108
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_2
    return-object v4
.end method

.method public static synthetic onNv21Data$default(Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;[BIIILkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 6

    .line 62
    and-int/lit8 p7, p6, 0x8

    if-eqz p7, :cond_0

    .line 66
    const/4 p4, 0x0

    move v4, p4

    goto :goto_0

    .line 62
    :cond_0
    move v4, p4

    :goto_0
    and-int/lit8 p4, p6, 0x10

    if-eqz p4, :cond_1

    .line 67
    sget-object p4, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer$onNv21Data$1;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer$onNv21Data$1;

    move-object p5, p4

    check-cast p5, Lkotlin/jvm/functions/Function1;

    move-object v5, p5

    goto :goto_1

    .line 62
    :cond_1
    move-object v5, p5

    :goto_1
    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    invoke-virtual/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->onNv21Data([BIIILkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method private static final onNv21Data$lambda$1(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)V
    .locals 1
    .param p0, "$tmp0"    # Lkotlin/jvm/functions/Function1;
    .param p1, "p0"    # Ljava/lang/Object;

    const-string v0, "$tmp0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 89
    invoke-interface {p0, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private static final onNv21Data$lambda$2(Lkotlin/jvm/functions/Function1;Ljava/lang/Exception;)V
    .locals 2
    .param p0, "$onResult"    # Lkotlin/jvm/functions/Function1;
    .param p1, "e"    # Ljava/lang/Exception;

    const-string v0, "$onResult"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "e"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 100
    const/4 v0, 0x0

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->isBlocked:Z

    .line 101
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "\u4e8c\u7ef4\u7801\u68c0\u6d4b\u5931\u8d25: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "QrCodeAnalyzer"

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 102
    const/4 v0, 0x0

    invoke-interface {p0, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 103
    return-void
.end method


# virtual methods
.method public final addTopRedImageView(Landroid/app/Activity;)V
    .locals 5
    .param p1, "activity"    # Landroid/app/Activity;

    const-string v0, "activity"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 35
    new-instance v0, Landroid/widget/ImageView;

    move-object v1, p1

    check-cast v1, Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    move-object v1, v0

    .local v1, "$this$addTopRedImageView_u24lambda_u240":Landroid/widget/ImageView;
    const/4 v2, 0x0

    .line 36
    .local v2, "$i$a$-apply-InspectQrCodeAnalyzer$addTopRedImageView$1":I
    const/high16 v3, 0x4dff0000    # 5.3477376E8f

    invoke-virtual {v1, v3}, Landroid/widget/ImageView;->setBackgroundColor(I)V

    .line 37
    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;

    .line 38
    nop

    .line 39
    nop

    .line 37
    const/4 v4, -0x1

    invoke-direct {v3, v4, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    check-cast v3, Landroid/view/ViewGroup$LayoutParams;

    invoke-virtual {v1, v3}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 41
    nop

    .line 35
    .end local v1    # "$this$addTopRedImageView_u24lambda_u240":Landroid/widget/ImageView;
    .end local v2    # "$i$a$-apply-InspectQrCodeAnalyzer$addTopRedImageView$1":I
    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->imageView:Landroid/widget/ImageView;

    .line 44
    invoke-virtual {p1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    const-string v1, "null cannot be cast to non-null type android.view.ViewGroup"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/view/ViewGroup;

    .line 47
    .local v0, "rootView":Landroid/view/ViewGroup;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->imageView:Landroid/widget/ImageView;

    check-cast v1, Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 50
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->imageView:Landroid/widget/ImageView;

    const/4 v2, 0x0

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setClickable(Z)V

    .line 51
    :goto_0
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->imageView:Landroid/widget/ImageView;

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setFocusable(Z)V

    .line 52
    :goto_1
    return-void
.end method

.method public final attach(Landroid/app/Activity;)V
    .locals 1
    .param p1, "activity"    # Landroid/app/Activity;

    const-string v0, "activity"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 56
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->activityRef:Ljava/lang/ref/WeakReference;

    .line 57
    return-void
.end method

.method public final onNv21Data([BIIILkotlin/jvm/functions/Function1;)V
    .locals 6
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I
    .param p4, "rotation"    # I
    .param p5, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([BIII",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onResult"

    invoke-static {p5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 69
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "1\u66f4\u65b0\u9884\u89c8: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x78

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "QrCodeAnalyzer"

    invoke-static {v2, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 71
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "2\u66f4\u65b0\u9884\u89c8: "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 72
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->isBlocked:Z

    if-eqz v0, :cond_0

    return-void

    .line 75
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .line 76
    .local v0, "now":J
    const/16 v2, 0x11

    invoke-static {p1, p2, p3, p4, v2}, Lcom/google/mlkit/vision/common/InputImage;->fromByteArray([BIIII)Lcom/google/mlkit/vision/common/InputImage;

    move-result-object v2

    const-string v3, "fromByteArray(data, widt\u2026tation, ImageFormat.NV21)"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 88
    .local v2, "image":Lcom/google/mlkit/vision/common/InputImage;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->scanner:Lcom/google/mlkit/vision/barcode/BarcodeScanner;

    invoke-interface {v3, v2}, Lcom/google/mlkit/vision/barcode/BarcodeScanner;->process(Lcom/google/mlkit/vision/common/InputImage;)Lcom/google/android/gms/tasks/Task;

    move-result-object v3

    .line 89
    new-instance v4, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer$onNv21Data$2;

    invoke-direct {v4, p5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer$onNv21Data$2;-><init>(Lkotlin/jvm/functions/Function1;)V

    check-cast v4, Lkotlin/jvm/functions/Function1;

    new-instance v5, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer$$ExternalSyntheticLambda0;

    invoke-direct {v5, v4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer$$ExternalSyntheticLambda0;-><init>(Lkotlin/jvm/functions/Function1;)V

    invoke-virtual {v3, v5}, Lcom/google/android/gms/tasks/Task;->addOnSuccessListener(Lcom/google/android/gms/tasks/OnSuccessListener;)Lcom/google/android/gms/tasks/Task;

    move-result-object v3

    .line 99
    new-instance v4, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer$$ExternalSyntheticLambda1;

    invoke-direct {v4, p5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer$$ExternalSyntheticLambda1;-><init>(Lkotlin/jvm/functions/Function1;)V

    invoke-virtual {v3, v4}, Lcom/google/android/gms/tasks/Task;->addOnFailureListener(Lcom/google/android/gms/tasks/OnFailureListener;)Lcom/google/android/gms/tasks/Task;

    .line 104
    return-void
.end method

.method public final release()V
    .locals 6

    .line 127
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->scanner:Lcom/google/mlkit/vision/barcode/BarcodeScanner;

    invoke-interface {v0}, Lcom/google/mlkit/vision/barcode/BarcodeScanner;->close()V

    .line 128
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->activityRef:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    if-eqz v0, :cond_0

    .local v0, "act":Landroid/app/Activity;
    const/4 v1, 0x0

    .line 129
    .local v1, "$i$a$-let-InspectQrCodeAnalyzer$release$1":I
    invoke-virtual {v0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v2

    const-string v3, "null cannot be cast to non-null type android.view.ViewGroup"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v2, Landroid/view/ViewGroup;

    .line 130
    .local v2, "decor":Landroid/view/ViewGroup;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->imageView:Landroid/widget/ImageView;

    if-eqz v3, :cond_0

    .line 138
    .local v3, "it":Landroid/widget/ImageView;
    const/4 v4, 0x0

    .line 130
    .local v4, "$i$a$-let-InspectQrCodeAnalyzer$release$1$1":I
    move-object v5, v3

    check-cast v5, Landroid/view/View;

    invoke-virtual {v2, v5}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 128
    .end local v0    # "act":Landroid/app/Activity;
    .end local v1    # "$i$a$-let-InspectQrCodeAnalyzer$release$1":I
    .end local v2    # "decor":Landroid/view/ViewGroup;
    .end local v3    # "it":Landroid/widget/ImageView;
    .end local v4    # "$i$a$-let-InspectQrCodeAnalyzer$release$1$1":I
    :cond_0
    nop

    .line 132
    const/4 v0, 0x0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->imageView:Landroid/widget/ImageView;

    .line 133
    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->activityRef:Ljava/lang/ref/WeakReference;

    .line 134
    const-string v0, "QrCodeAnalyzer"

    const-string/jumbo v1, "\ud83d\udd3b QrPreview ImageView \u5df2\u79fb\u9664"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 135
    return-void
.end method
