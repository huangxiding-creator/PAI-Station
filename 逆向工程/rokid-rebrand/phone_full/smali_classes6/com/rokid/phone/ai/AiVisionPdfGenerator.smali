.class public final Lcom/rokid/phone/ai/AiVisionPdfGenerator;
.super Ljava/lang/Object;
.source "AiVisionPdfGenerator.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nAiVisionPdfGenerator.kt\nKotlin\n*S Kotlin\n*F\n+ 1 AiVisionPdfGenerator.kt\ncom/rokid/phone/ai/AiVisionPdfGenerator\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n+ 4 _Sequences.kt\nkotlin/sequences/SequencesKt___SequencesKt\n*L\n1#1,239:1\n1#2:240\n1#2:254\n1056#3:241\n1617#3,9:244\n1869#3:253\n1870#3:255\n1626#3:256\n1869#3,2:257\n183#4,2:242\n1321#4,2:259\n*S KotlinDebug\n*F\n+ 1 AiVisionPdfGenerator.kt\ncom/rokid/phone/ai/AiVisionPdfGenerator\n*L\n134#1:254\n114#1:241\n134#1:244,9\n134#1:253\n134#1:255\n134#1:256\n147#1:257,2\n118#1:242,2\n87#1:259,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000@\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0003\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u0007\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0008\u00c6\u0002\u0018\u00002\u00020\u0001:\u0001\u0019B\t\u0008\u0002\u00a2\u0006\u0004\u0008\u0002\u0010\u0003J&\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000e2\u000c\u0010\u000f\u001a\u0008\u0012\u0004\u0012\u00020\u00110\u00102\u0008\u0008\u0002\u0010\u0012\u001a\u00020\u0013J*\u0010\u0014\u001a\u0004\u0018\u00010\u00152\u0006\u0010\r\u001a\u00020\u000e2\u0006\u0010\u0016\u001a\u00020\u00112\u0006\u0010\u0017\u001a\u00020\u00052\u0006\u0010\u0018\u001a\u00020\u0005H\u0002R\u000e\u0010\u0004\u001a\u00020\u0005X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0005X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0008X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0008X\u0082T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001a"
    }
    d2 = {
        "Lcom/rokid/phone/ai/AiVisionPdfGenerator;",
        "",
        "<init>",
        "()V",
        "PAGE_WIDTH",
        "",
        "PAGE_HEIGHT",
        "MARGIN",
        "",
        "CONTENT_WIDTH",
        "PAGE_BOTTOM",
        "generate",
        "Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;",
        "context",
        "Landroid/content/Context;",
        "records",
        "",
        "Lcom/rokid/phone/ai/AiVisionRecord;",
        "generatedAt",
        "",
        "loadThumbnail",
        "Landroid/graphics/Bitmap;",
        "record",
        "maxWidth",
        "maxHeight",
        "Result",
        "app_debug"
    }
    k = 0x1
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field private static final CONTENT_WIDTH:F = 523.0f

.field public static final INSTANCE:Lcom/rokid/phone/ai/AiVisionPdfGenerator;

.field private static final MARGIN:F = 36.0f

.field private static final PAGE_BOTTOM:F = 806.0f

.field private static final PAGE_HEIGHT:I = 0x34a

.field private static final PAGE_WIDTH:I = 0x253


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/phone/ai/AiVisionPdfGenerator;

    invoke-direct {v0}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;-><init>()V

    sput-object v0, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->INSTANCE:Lcom/rokid/phone/ai/AiVisionPdfGenerator;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static synthetic generate$default(Lcom/rokid/phone/ai/AiVisionPdfGenerator;Landroid/content/Context;Ljava/util/List;JILjava/lang/Object;)Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;
    .locals 0

    .line 34
    and-int/lit8 p5, p5, 0x4

    if-eqz p5, :cond_0

    .line 37
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p3

    .line 34
    :cond_0
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate(Landroid/content/Context;Ljava/util/List;J)Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

    move-result-object p0

    return-object p0
.end method

.method private static final generate$drawImage(Landroid/content/Context;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$FloatRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Lcom/rokid/phone/ai/AiVisionRecord;)V
    .locals 9
    .param p0, "$context"    # Landroid/content/Context;
    .param p1, "canvas"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p2, "y"    # Lkotlin/jvm/internal/Ref$FloatRef;
    .param p3, "document"    # Landroid/graphics/pdf/PdfDocument;
    .param p4, "page"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p5, "pageNumber"    # Lkotlin/jvm/internal/Ref$IntRef;
    .param p6, "record"    # Lcom/rokid/phone/ai/AiVisionRecord;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Landroid/graphics/Canvas;",
            ">;",
            "Lkotlin/jvm/internal/Ref$FloatRef;",
            "Landroid/graphics/pdf/PdfDocument;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Landroid/graphics/pdf/PdfDocument$Page;",
            ">;",
            "Lkotlin/jvm/internal/Ref$IntRef;",
            "Lcom/rokid/phone/ai/AiVisionRecord;",
            ")V"
        }
    .end annotation

    .line 106
    sget-object v0, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->INSTANCE:Lcom/rokid/phone/ai/AiVisionPdfGenerator;

    const/16 v1, 0xfa

    const/16 v2, 0x96

    invoke-direct {v0, p0, p6, v1, v2}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->loadThumbnail(Landroid/content/Context;Lcom/rokid/phone/ai/AiVisionRecord;II)Landroid/graphics/Bitmap;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    .line 107
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    :cond_0
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    int-to-float v1, v1

    const/high16 v2, 0x41200000    # 10.0f

    add-float v8, v1, v2

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    move-object v7, p1

    invoke-static/range {v3 .. v8}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate$ensureSpace(Lkotlin/jvm/internal/Ref$FloatRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/jvm/internal/Ref$ObjectRef;F)V

    .line 108
    iget-object v1, p1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Landroid/graphics/Canvas;

    iget v3, p2, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    const/4 v4, 0x0

    const/high16 v5, 0x42100000    # 36.0f

    invoke-virtual {v1, v0, v5, v3, v4}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V

    .line 109
    iget v1, p2, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v3

    int-to-float v3, v3

    add-float/2addr v3, v2

    add-float/2addr v1, v3

    iput v1, p2, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    .line 110
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V

    .line 111
    return-void
.end method

.method private static final generate$drawParagraph(Lkotlin/jvm/internal/Ref$FloatRef;Lkotlin/jvm/internal/Ref$ObjectRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Landroid/graphics/Paint;F)V
    .locals 19
    .param p0, "y"    # Lkotlin/jvm/internal/Ref$FloatRef;
    .param p1, "canvas"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p2, "document"    # Landroid/graphics/pdf/PdfDocument;
    .param p3, "page"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p4, "pageNumber"    # Lkotlin/jvm/internal/Ref$IntRef;
    .param p5, "text"    # Ljava/lang/String;
    .param p6, "paint"    # Landroid/graphics/Paint;
    .param p7, "spacingAfter"    # F
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/internal/Ref$FloatRef;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Landroid/graphics/Canvas;",
            ">;",
            "Landroid/graphics/pdf/PdfDocument;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Landroid/graphics/pdf/PdfDocument$Page;",
            ">;",
            "Lkotlin/jvm/internal/Ref$IntRef;",
            "Ljava/lang/String;",
            "Landroid/graphics/Paint;",
            "F)V"
        }
    .end annotation

    .line 86
    move-object/from16 v6, p0

    move-object/from16 v7, p6

    invoke-virtual/range {p6 .. p6}, Landroid/graphics/Paint;->getTextSize()F

    move-result v0

    const v1, 0x3fb9999a    # 1.45f

    mul-float v8, v0, v1

    .line 87
    .local v8, "lineHeight":F
    move-object/from16 v0, p5

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 240
    const/4 v0, 0x0

    .line 87
    .local v0, "$i$a$-ifBlank-AiVisionPdfGenerator$generate$drawParagraph$1":I
    nop

    .end local v0    # "$i$a$-ifBlank-AiVisionPdfGenerator$generate$drawParagraph$1":I
    const-string v0, " "

    :cond_0
    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->lineSequence(Ljava/lang/CharSequence;)Lkotlin/sequences/Sequence;

    move-result-object v9

    .local v9, "$this$forEach$iv":Lkotlin/sequences/Sequence;
    const/4 v10, 0x0

    .line 259
    .local v10, "$i$f$forEach":I
    invoke-interface {v9}, Lkotlin/sequences/Sequence;->iterator()Ljava/util/Iterator;

    move-result-object v11

    :goto_0
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    .local v12, "element$iv":Ljava/lang/Object;
    move-object v13, v12

    check-cast v13, Ljava/lang/String;

    .local v13, "sourceLine":Ljava/lang/String;
    const/4 v14, 0x0

    .line 88
    .local v14, "$i$a$-forEach-AiVisionPdfGenerator$generate$drawParagraph$2":I
    move-object v15, v13

    .line 89
    .local v15, "remaining":Ljava/lang/String;
    move-object v0, v15

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/4 v5, 0x0

    const/4 v4, 0x1

    if-nez v0, :cond_1

    move v0, v4

    goto :goto_1

    :cond_1
    move v0, v5

    :goto_1
    if-eqz v0, :cond_2

    .line 90
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v2, p3

    move-object/from16 v3, p4

    move-object/from16 v4, p1

    move v5, v8

    invoke-static/range {v0 .. v5}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate$ensureSpace(Lkotlin/jvm/internal/Ref$FloatRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/jvm/internal/Ref$ObjectRef;F)V

    .line 91
    iget v0, v6, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    add-float/2addr v0, v8

    iput v0, v6, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    .line 92
    move-object/from16 v0, p1

    move-object/from16 v16, v9

    move/from16 v18, v10

    goto/16 :goto_4

    .line 94
    :cond_2
    :goto_2
    move-object v0, v15

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-lez v0, :cond_3

    move v0, v4

    goto :goto_3

    :cond_3
    move v0, v5

    :goto_3
    if-eqz v0, :cond_4

    .line 95
    const v0, 0x4402c000    # 523.0f

    const/4 v1, 0x0

    invoke-virtual {v7, v15, v4, v0, v1}, Landroid/graphics/Paint;->breakText(Ljava/lang/String;ZF[F)I

    move-result v0

    invoke-static {v4, v0}, Ljava/lang/Math;->max(II)I

    move-result v3

    .line 96
    .local v3, "count":I
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v2, p3

    move-object/from16 v16, v9

    move v9, v3

    .end local v3    # "count":I
    .local v9, "count":I
    .local v16, "$this$forEach$iv":Lkotlin/sequences/Sequence;
    move-object/from16 v3, p4

    move/from16 v17, v4

    move-object/from16 v4, p1

    move/from16 v18, v10

    move v10, v5

    .end local v10    # "$i$f$forEach":I
    .local v18, "$i$f$forEach":I
    move v5, v8

    invoke-static/range {v0 .. v5}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate$ensureSpace(Lkotlin/jvm/internal/Ref$FloatRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/jvm/internal/Ref$ObjectRef;F)V

    .line 97
    move-object/from16 v0, p1

    iget-object v1, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v1, Landroid/graphics/Canvas;

    invoke-virtual {v15, v10, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    const-string v3, "substring(...)"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    iget v4, v6, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    invoke-virtual/range {p6 .. p6}, Landroid/graphics/Paint;->getTextSize()F

    move-result v5

    add-float/2addr v4, v5

    const/high16 v5, 0x42100000    # 36.0f

    invoke-virtual {v1, v2, v5, v4, v7}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 98
    iget v1, v6, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    add-float/2addr v1, v8

    iput v1, v6, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    .line 99
    invoke-virtual {v15, v9}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v15, v1

    move v5, v10

    move-object/from16 v9, v16

    move/from16 v4, v17

    move/from16 v10, v18

    .end local v9    # "count":I
    goto :goto_2

    .line 101
    .end local v16    # "$this$forEach$iv":Lkotlin/sequences/Sequence;
    .end local v18    # "$i$f$forEach":I
    .local v9, "$this$forEach$iv":Lkotlin/sequences/Sequence;
    .restart local v10    # "$i$f$forEach":I
    :cond_4
    move-object/from16 v0, p1

    move-object/from16 v16, v9

    move/from16 v18, v10

    .line 259
    .end local v9    # "$this$forEach$iv":Lkotlin/sequences/Sequence;
    .end local v10    # "$i$f$forEach":I
    .end local v13    # "sourceLine":Ljava/lang/String;
    .end local v14    # "$i$a$-forEach-AiVisionPdfGenerator$generate$drawParagraph$2":I
    .end local v15    # "remaining":Ljava/lang/String;
    .restart local v16    # "$this$forEach$iv":Lkotlin/sequences/Sequence;
    .restart local v18    # "$i$f$forEach":I
    :goto_4
    move-object/from16 v9, v16

    move/from16 v10, v18

    .end local v12    # "element$iv":Ljava/lang/Object;
    goto/16 :goto_0

    .line 260
    .end local v16    # "$this$forEach$iv":Lkotlin/sequences/Sequence;
    .end local v18    # "$i$f$forEach":I
    .restart local v9    # "$this$forEach$iv":Lkotlin/sequences/Sequence;
    .restart local v10    # "$i$f$forEach":I
    :cond_5
    nop

    .line 102
    .end local v9    # "$this$forEach$iv":Lkotlin/sequences/Sequence;
    .end local v10    # "$i$f$forEach":I
    iget v1, v6, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    add-float v1, v1, p7

    iput v1, v6, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    .line 103
    return-void
.end method

.method static synthetic generate$drawParagraph$default(Lkotlin/jvm/internal/Ref$FloatRef;Lkotlin/jvm/internal/Ref$ObjectRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Landroid/graphics/Paint;FILjava/lang/Object;)V
    .locals 9

    .line 85
    move/from16 v0, p8

    and-int/lit16 v0, v0, 0x80

    if-eqz v0, :cond_0

    const/high16 v0, 0x40c00000    # 6.0f

    move v8, v0

    goto :goto_0

    :cond_0
    move/from16 v8, p7

    :goto_0
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    move-object v7, p6

    invoke-static/range {v1 .. v8}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate$drawParagraph(Lkotlin/jvm/internal/Ref$FloatRef;Lkotlin/jvm/internal/Ref$ObjectRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Landroid/graphics/Paint;F)V

    return-void
.end method

.method private static final generate$ensureSpace(Lkotlin/jvm/internal/Ref$FloatRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/jvm/internal/Ref$ObjectRef;F)V
    .locals 2
    .param p0, "y"    # Lkotlin/jvm/internal/Ref$FloatRef;
    .param p1, "document"    # Landroid/graphics/pdf/PdfDocument;
    .param p2, "page"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p3, "pageNumber"    # Lkotlin/jvm/internal/Ref$IntRef;
    .param p4, "canvas"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p5, "height"    # F
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/internal/Ref$FloatRef;",
            "Landroid/graphics/pdf/PdfDocument;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Landroid/graphics/pdf/PdfDocument$Page;",
            ">;",
            "Lkotlin/jvm/internal/Ref$IntRef;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Landroid/graphics/Canvas;",
            ">;F)V"
        }
    .end annotation

    .line 82
    iget v0, p0, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    add-float/2addr v0, p5

    const v1, 0x44498000    # 806.0f

    cmpl-float v0, v0, v1

    if-lez v0, :cond_0

    invoke-static {p1, p2, p3, p4, p0}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate$startNewPage(Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$FloatRef;)V

    .line 83
    :cond_0
    return-void
.end method

.method private static final generate$startNewPage(Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$FloatRef;)V
    .locals 4
    .param p0, "document"    # Landroid/graphics/pdf/PdfDocument;
    .param p1, "page"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p2, "pageNumber"    # Lkotlin/jvm/internal/Ref$IntRef;
    .param p3, "canvas"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p4, "y"    # Lkotlin/jvm/internal/Ref$FloatRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/graphics/pdf/PdfDocument;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Landroid/graphics/pdf/PdfDocument$Page;",
            ">;",
            "Lkotlin/jvm/internal/Ref$IntRef;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Landroid/graphics/Canvas;",
            ">;",
            "Lkotlin/jvm/internal/Ref$FloatRef;",
            ")V"
        }
    .end annotation

    .line 72
    iget-object v0, p1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v0, Landroid/graphics/pdf/PdfDocument$Page;

    invoke-virtual {p0, v0}, Landroid/graphics/pdf/PdfDocument;->finishPage(Landroid/graphics/pdf/PdfDocument$Page;)V

    .line 73
    iget v0, p2, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p2, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    .line 74
    nop

    .line 75
    new-instance v0, Landroid/graphics/pdf/PdfDocument$PageInfo$Builder;

    const/16 v1, 0x34a

    iget v2, p2, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    const/16 v3, 0x253

    invoke-direct {v0, v3, v1, v2}, Landroid/graphics/pdf/PdfDocument$PageInfo$Builder;-><init>(III)V

    invoke-virtual {v0}, Landroid/graphics/pdf/PdfDocument$PageInfo$Builder;->create()Landroid/graphics/pdf/PdfDocument$PageInfo;

    move-result-object v0

    .line 74
    invoke-virtual {p0, v0}, Landroid/graphics/pdf/PdfDocument;->startPage(Landroid/graphics/pdf/PdfDocument$PageInfo;)Landroid/graphics/pdf/PdfDocument$Page;

    move-result-object v0

    iput-object v0, p1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 77
    iget-object v0, p1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v0, Landroid/graphics/pdf/PdfDocument$Page;

    invoke-virtual {v0}, Landroid/graphics/pdf/PdfDocument$Page;->getCanvas()Landroid/graphics/Canvas;

    move-result-object v0

    iput-object v0, p3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 78
    const/high16 v0, 0x42100000    # 36.0f

    iput v0, p4, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    .line 79
    return-void
.end method

.method private final loadThumbnail(Landroid/content/Context;Lcom/rokid/phone/ai/AiVisionRecord;II)Landroid/graphics/Bitmap;
    .locals 15
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "record"    # Lcom/rokid/phone/ai/AiVisionRecord;
    .param p3, "maxWidth"    # I
    .param p4, "maxHeight"    # I

    .line 199
    move/from16 v1, p3

    move/from16 v2, p4

    invoke-virtual/range {p2 .. p2}, Lcom/rokid/phone/ai/AiVisionRecord;->getImageUrl()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/phone/ai/AiVisionStoreKt;->resolveAiVisionImageUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    const/4 v3, 0x0

    if-nez v0, :cond_0

    return-object v3

    :cond_0
    move-object v4, v0

    .line 200
    .local v4, "uri":Landroid/net/Uri;
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    move-object v5, v0

    .line 240
    .local v5, "$this$loadThumbnail_u24lambda_u2416":Landroid/graphics/BitmapFactory$Options;
    const/4 v6, 0x0

    .line 200
    .local v6, "$i$a$-apply-AiVisionPdfGenerator$loadThumbnail$bounds$1":I
    const/4 v7, 0x1

    iput-boolean v7, v5, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 201
    .end local v6    # "$i$a$-apply-AiVisionPdfGenerator$loadThumbnail$bounds$1":I
    .local v5, "bounds":Landroid/graphics/BitmapFactory$Options;
    :try_start_0
    sget-object v0, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v0, p0

    check-cast v0, Lcom/rokid/phone/ai/AiVisionPdfGenerator;

    move-object v6, v0

    .local v6, "$this$loadThumbnail_u24lambda_u2418":Lcom/rokid/phone/ai/AiVisionPdfGenerator;
    const/4 v8, 0x0

    .line 202
    .local v8, "$i$a$-runCatching-AiVisionPdfGenerator$loadThumbnail$1":I
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v0

    if-eqz v0, :cond_1

    move-object v9, v0

    check-cast v9, Ljava/io/Closeable;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    :try_start_1
    move-object v0, v9

    check-cast v0, Ljava/io/InputStream;

    .local v0, "it":Ljava/io/InputStream;
    const/4 v10, 0x0

    .line 203
    .local v10, "$i$a$-use-AiVisionPdfGenerator$loadThumbnail$1$1":I
    invoke-static {v0, v3, v5}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v11
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 202
    .end local v0    # "it":Ljava/io/InputStream;
    .end local v10    # "$i$a$-use-AiVisionPdfGenerator$loadThumbnail$1$1":I
    :try_start_2
    invoke-static {v9, v3}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_0

    :catchall_0
    move-exception v0

    move-object v10, v0

    .end local v4    # "uri":Landroid/net/Uri;
    .end local v5    # "bounds":Landroid/graphics/BitmapFactory$Options;
    .end local v6    # "$this$loadThumbnail_u24lambda_u2418":Lcom/rokid/phone/ai/AiVisionPdfGenerator;
    .end local v8    # "$i$a$-runCatching-AiVisionPdfGenerator$loadThumbnail$1":I
    .end local p1    # "context":Landroid/content/Context;
    .end local p2    # "record":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local p3    # "maxWidth":I
    .end local p4    # "maxHeight":I
    :try_start_3
    throw v10
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .restart local v4    # "uri":Landroid/net/Uri;
    .restart local v5    # "bounds":Landroid/graphics/BitmapFactory$Options;
    .restart local v6    # "$this$loadThumbnail_u24lambda_u2418":Lcom/rokid/phone/ai/AiVisionPdfGenerator;
    .restart local v8    # "$i$a$-runCatching-AiVisionPdfGenerator$loadThumbnail$1":I
    .restart local p1    # "context":Landroid/content/Context;
    .restart local p2    # "record":Lcom/rokid/phone/ai/AiVisionRecord;
    .restart local p3    # "maxWidth":I
    .restart local p4    # "maxHeight":I
    :catchall_1
    move-exception v0

    move-object v11, v0

    :try_start_4
    invoke-static {v9, v10}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v4    # "uri":Landroid/net/Uri;
    .end local v5    # "bounds":Landroid/graphics/BitmapFactory$Options;
    .end local p1    # "context":Landroid/content/Context;
    .end local p2    # "record":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local p3    # "maxWidth":I
    .end local p4    # "maxHeight":I
    throw v11

    .restart local v4    # "uri":Landroid/net/Uri;
    .restart local v5    # "bounds":Landroid/graphics/BitmapFactory$Options;
    .restart local p1    # "context":Landroid/content/Context;
    .restart local p2    # "record":Lcom/rokid/phone/ai/AiVisionRecord;
    .restart local p3    # "maxWidth":I
    .restart local p4    # "maxHeight":I
    :cond_1
    move-object v11, v3

    .line 204
    :goto_0
    nop

    .line 201
    .end local v6    # "$this$loadThumbnail_u24lambda_u2418":Lcom/rokid/phone/ai/AiVisionPdfGenerator;
    .end local v8    # "$i$a$-runCatching-AiVisionPdfGenerator$loadThumbnail$1":I
    invoke-static {v11}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    goto :goto_1

    :catchall_2
    move-exception v0

    sget-object v6, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 205
    :goto_1
    invoke-static {v0}, Lkotlin/Result;->isFailure-impl(Ljava/lang/Object;)Z

    .line 206
    iget v0, v5, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    if-lez v0, :cond_9

    iget v0, v5, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    if-gtz v0, :cond_2

    goto/16 :goto_5

    .line 208
    :cond_2
    const/4 v0, 0x0

    .local v0, "sample":I
    const/4 v0, 0x1

    move v6, v0

    .line 209
    .end local v0    # "sample":I
    .local v6, "sample":I
    :goto_2
    iget v0, v5, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    mul-int/lit8 v8, v6, 0x2

    div-int/2addr v0, v8

    if-lt v0, v1, :cond_3

    .line 210
    iget v0, v5, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    mul-int/lit8 v8, v6, 0x2

    div-int/2addr v0, v8

    if-lt v0, v2, :cond_3

    .line 212
    mul-int/lit8 v6, v6, 0x2

    goto :goto_2

    .line 214
    :cond_3
    :try_start_5
    sget-object v0, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v0, p0

    check-cast v0, Lcom/rokid/phone/ai/AiVisionPdfGenerator;

    move-object v8, v0

    .local v8, "$this$loadThumbnail_u24lambda_u2421":Lcom/rokid/phone/ai/AiVisionPdfGenerator;
    const/4 v9, 0x0

    .line 215
    .local v9, "$i$a$-runCatching-AiVisionPdfGenerator$loadThumbnail$decoded$1":I
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v0

    if-eqz v0, :cond_4

    move-object v10, v0

    check-cast v10, Ljava/io/Closeable;
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_5

    :try_start_6
    move-object v0, v10

    check-cast v0, Ljava/io/InputStream;

    .local v0, "it":Ljava/io/InputStream;
    const/4 v11, 0x0

    .line 217
    .local v11, "$i$a$-use-AiVisionPdfGenerator$loadThumbnail$decoded$1$1":I
    nop

    .line 218
    nop

    .line 219
    new-instance v12, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v12}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 240
    move-object v13, v12

    .local v13, "$this$loadThumbnail_u24lambda_u2421_u24lambda_u2420_u24lambda_u2419":Landroid/graphics/BitmapFactory$Options;
    const/4 v14, 0x0

    .line 219
    .local v14, "$i$a$-apply-AiVisionPdfGenerator$loadThumbnail$decoded$1$1$1":I
    iput v6, v13, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .end local v13    # "$this$loadThumbnail_u24lambda_u2421_u24lambda_u2420_u24lambda_u2419":Landroid/graphics/BitmapFactory$Options;
    .end local v14    # "$i$a$-apply-AiVisionPdfGenerator$loadThumbnail$decoded$1$1$1":I
    sget-object v13, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 216
    invoke-static {v0, v3, v12}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v12
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 220
    nop

    .line 215
    .end local v0    # "it":Ljava/io/InputStream;
    .end local v11    # "$i$a$-use-AiVisionPdfGenerator$loadThumbnail$decoded$1$1":I
    :try_start_7
    invoke-static {v10, v3}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_5

    goto :goto_3

    :catchall_3
    move-exception v0

    move-object v11, v0

    .end local v4    # "uri":Landroid/net/Uri;
    .end local v5    # "bounds":Landroid/graphics/BitmapFactory$Options;
    .end local v6    # "sample":I
    .end local v8    # "$this$loadThumbnail_u24lambda_u2421":Lcom/rokid/phone/ai/AiVisionPdfGenerator;
    .end local v9    # "$i$a$-runCatching-AiVisionPdfGenerator$loadThumbnail$decoded$1":I
    .end local p1    # "context":Landroid/content/Context;
    .end local p2    # "record":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local p3    # "maxWidth":I
    .end local p4    # "maxHeight":I
    :try_start_8
    throw v11
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_4

    .restart local v4    # "uri":Landroid/net/Uri;
    .restart local v5    # "bounds":Landroid/graphics/BitmapFactory$Options;
    .restart local v6    # "sample":I
    .restart local v8    # "$this$loadThumbnail_u24lambda_u2421":Lcom/rokid/phone/ai/AiVisionPdfGenerator;
    .restart local v9    # "$i$a$-runCatching-AiVisionPdfGenerator$loadThumbnail$decoded$1":I
    .restart local p1    # "context":Landroid/content/Context;
    .restart local p2    # "record":Lcom/rokid/phone/ai/AiVisionRecord;
    .restart local p3    # "maxWidth":I
    .restart local p4    # "maxHeight":I
    :catchall_4
    move-exception v0

    move-object v12, v0

    :try_start_9
    invoke-static {v10, v11}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v4    # "uri":Landroid/net/Uri;
    .end local v5    # "bounds":Landroid/graphics/BitmapFactory$Options;
    .end local v6    # "sample":I
    .end local p1    # "context":Landroid/content/Context;
    .end local p2    # "record":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local p3    # "maxWidth":I
    .end local p4    # "maxHeight":I
    throw v12

    .restart local v4    # "uri":Landroid/net/Uri;
    .restart local v5    # "bounds":Landroid/graphics/BitmapFactory$Options;
    .restart local v6    # "sample":I
    .restart local p1    # "context":Landroid/content/Context;
    .restart local p2    # "record":Lcom/rokid/phone/ai/AiVisionRecord;
    .restart local p3    # "maxWidth":I
    .restart local p4    # "maxHeight":I
    :cond_4
    move-object v12, v3

    .line 221
    :goto_3
    nop

    .line 214
    .end local v8    # "$this$loadThumbnail_u24lambda_u2421":Lcom/rokid/phone/ai/AiVisionPdfGenerator;
    .end local v9    # "$i$a$-runCatching-AiVisionPdfGenerator$loadThumbnail$decoded$1":I
    invoke-static {v12}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_5

    goto :goto_4

    :catchall_5
    move-exception v0

    sget-object v8, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 222
    :goto_4
    invoke-static {v0}, Lkotlin/Result;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_5

    move-object v0, v3

    :cond_5
    check-cast v0, Landroid/graphics/Bitmap;

    .line 214
    if-nez v0, :cond_6

    .line 222
    return-object v3

    .line 223
    .local v0, "decoded":Landroid/graphics/Bitmap;
    :cond_6
    nop

    .line 224
    int-to-float v3, v1

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v8

    int-to-float v8, v8

    div-float/2addr v3, v8

    .line 225
    int-to-float v8, v2

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v9

    int-to-float v9, v9

    div-float/2addr v8, v9

    .line 226
    const/high16 v9, 0x3f800000    # 1.0f

    invoke-static {v8, v9}, Ljava/lang/Math;->min(FF)F

    move-result v8

    invoke-static {v3, v8}, Ljava/lang/Math;->min(FF)F

    move-result v3

    .line 223
    nop

    .line 228
    .local v3, "scale":F
    cmpl-float v8, v3, v9

    if-ltz v8, :cond_7

    return-object v0

    .line 230
    :cond_7
    nop

    .line 231
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v8

    int-to-float v8, v8

    mul-float/2addr v8, v3

    float-to-int v8, v8

    invoke-static {v8, v7}, Lkotlin/ranges/RangesKt;->coerceAtLeast(II)I

    move-result v8

    .line 232
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v9

    int-to-float v9, v9

    mul-float/2addr v9, v3

    float-to-int v9, v9

    invoke-static {v9, v7}, Lkotlin/ranges/RangesKt;->coerceAtLeast(II)I

    move-result v9

    .line 233
    nop

    .line 229
    invoke-static {v0, v8, v9, v7}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v7

    const-string v8, "createScaledBitmap(...)"

    invoke-static {v7, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 235
    .local v7, "scaled":Landroid/graphics/Bitmap;
    if-eq v7, v0, :cond_8

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V

    .line 236
    :cond_8
    return-object v7

    .line 206
    .end local v0    # "decoded":Landroid/graphics/Bitmap;
    .end local v3    # "scale":F
    .end local v6    # "sample":I
    .end local v7    # "scaled":Landroid/graphics/Bitmap;
    :cond_9
    :goto_5
    return-object v3
.end method


# virtual methods
.method public final generate(Landroid/content/Context;Ljava/util/List;J)Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;
    .locals 52
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "records"    # Ljava/util/List;
    .param p3, "generatedAt"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lcom/rokid/phone/ai/AiVisionRecord;",
            ">;J)",
            "Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;"
        }
    .end annotation

    move-object/from16 v8, p1

    move-object/from16 v9, p2

    move-wide/from16 v10, p3

    const-string v0, "context"

    invoke-static {v8, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "records"

    invoke-static {v9, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 39
    move-object v0, v9

    check-cast v0, Ljava/util/Collection;

    invoke-interface {v0}, Ljava/util/Collection;->isEmpty()Z

    move-result v0

    const/4 v1, 0x1

    xor-int/2addr v0, v1

    if-eqz v0, :cond_a

    .line 40
    new-instance v0, Landroid/graphics/pdf/PdfDocument;

    invoke-direct {v0}, Landroid/graphics/pdf/PdfDocument;-><init>()V

    move-object v7, v0

    .line 41
    .local v7, "document":Landroid/graphics/pdf/PdfDocument;
    new-instance v0, Lkotlin/jvm/internal/Ref$IntRef;

    invoke-direct {v0}, Lkotlin/jvm/internal/Ref$IntRef;-><init>()V

    move-object v6, v0

    .local v6, "pageNumber":Lkotlin/jvm/internal/Ref$IntRef;
    iput v1, v6, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    .line 42
    new-instance v0, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v0}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v5, v0

    .line 43
    .local v5, "page":Lkotlin/jvm/internal/Ref$ObjectRef;
    new-instance v0, Landroid/graphics/pdf/PdfDocument$PageInfo$Builder;

    const/16 v2, 0x34a

    iget v3, v6, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    const/16 v4, 0x253

    invoke-direct {v0, v4, v2, v3}, Landroid/graphics/pdf/PdfDocument$PageInfo$Builder;-><init>(III)V

    invoke-virtual {v0}, Landroid/graphics/pdf/PdfDocument$PageInfo$Builder;->create()Landroid/graphics/pdf/PdfDocument$PageInfo;

    move-result-object v0

    .line 42
    invoke-virtual {v7, v0}, Landroid/graphics/pdf/PdfDocument;->startPage(Landroid/graphics/pdf/PdfDocument$PageInfo;)Landroid/graphics/pdf/PdfDocument$Page;

    move-result-object v0

    iput-object v0, v5, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 45
    new-instance v0, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v0}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v4, v0

    .local v4, "canvas":Lkotlin/jvm/internal/Ref$ObjectRef;
    iget-object v0, v5, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v0, Landroid/graphics/pdf/PdfDocument$Page;

    invoke-virtual {v0}, Landroid/graphics/pdf/PdfDocument$Page;->getCanvas()Landroid/graphics/Canvas;

    move-result-object v0

    iput-object v0, v4, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 46
    new-instance v0, Lkotlin/jvm/internal/Ref$FloatRef;

    invoke-direct {v0}, Lkotlin/jvm/internal/Ref$FloatRef;-><init>()V

    move-object v3, v0

    .local v3, "y":Lkotlin/jvm/internal/Ref$FloatRef;
    const/high16 v0, 0x42100000    # 36.0f

    iput v0, v3, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    .line 48
    new-instance v2, Landroid/graphics/Paint;

    invoke-direct {v2, v1}, Landroid/graphics/Paint;-><init>(I)V

    move-object v12, v2

    .local v12, "$this$generate_u24lambda_u241":Landroid/graphics/Paint;
    const/4 v13, 0x0

    .line 49
    .local v13, "$i$a$-apply-AiVisionPdfGenerator$generate$titlePaint$1":I
    const/16 v14, 0x18

    const/16 v15, 0x22

    const/16 v0, 0x30

    invoke-static {v14, v15, v0}, Landroid/graphics/Color;->rgb(III)I

    move-result v14

    invoke-virtual {v12, v14}, Landroid/graphics/Paint;->setColor(I)V

    .line 50
    const/high16 v14, 0x41a00000    # 20.0f

    invoke-virtual {v12, v14}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 51
    sget-object v14, Landroid/graphics/Typeface;->DEFAULT:Landroid/graphics/Typeface;

    invoke-static {v14, v1}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;I)Landroid/graphics/Typeface;

    move-result-object v14

    invoke-virtual {v12, v14}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 52
    nop

    .line 48
    .end local v12    # "$this$generate_u24lambda_u241":Landroid/graphics/Paint;
    .end local v13    # "$i$a$-apply-AiVisionPdfGenerator$generate$titlePaint$1":I
    move-object/from16 v18, v2

    .line 53
    .local v18, "titlePaint":Landroid/graphics/Paint;
    new-instance v2, Landroid/graphics/Paint;

    invoke-direct {v2, v1}, Landroid/graphics/Paint;-><init>(I)V

    move-object v12, v2

    .local v12, "$this$generate_u24lambda_u242":Landroid/graphics/Paint;
    const/4 v13, 0x0

    .line 54
    .local v13, "$i$a$-apply-AiVisionPdfGenerator$generate$bodyPaint$1":I
    const/16 v14, 0x26

    const/16 v15, 0x3c

    invoke-static {v14, v0, v15}, Landroid/graphics/Color;->rgb(III)I

    move-result v1

    invoke-virtual {v12, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 55
    const/high16 v1, 0x41300000    # 11.0f

    invoke-virtual {v12, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 56
    nop

    .line 53
    .end local v12    # "$this$generate_u24lambda_u242":Landroid/graphics/Paint;
    .end local v13    # "$i$a$-apply-AiVisionPdfGenerator$generate$bodyPaint$1":I
    move-object/from16 v26, v2

    .line 57
    .local v26, "bodyPaint":Landroid/graphics/Paint;
    new-instance v2, Landroid/graphics/Paint;

    const/4 v12, 0x1

    invoke-direct {v2, v12}, Landroid/graphics/Paint;-><init>(I)V

    move-object v12, v2

    .local v12, "$this$generate_u24lambda_u243":Landroid/graphics/Paint;
    const/4 v13, 0x0

    .line 58
    .local v13, "$i$a$-apply-AiVisionPdfGenerator$generate$smallPaint$1":I
    const/16 v1, 0x68

    const/16 v0, 0x76

    const/16 v14, 0x5c

    invoke-static {v14, v1, v0}, Landroid/graphics/Color;->rgb(III)I

    move-result v0

    invoke-virtual {v12, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 59
    const/high16 v0, 0x41100000    # 9.0f

    invoke-virtual {v12, v0}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 60
    nop

    .line 57
    .end local v12    # "$this$generate_u24lambda_u243":Landroid/graphics/Paint;
    .end local v13    # "$i$a$-apply-AiVisionPdfGenerator$generate$smallPaint$1":I
    move-object v1, v2

    .line 61
    .local v1, "smallPaint":Landroid/graphics/Paint;
    new-instance v0, Landroid/graphics/Paint;

    const/4 v2, 0x1

    invoke-direct {v0, v2}, Landroid/graphics/Paint;-><init>(I)V

    move-object v12, v0

    .local v12, "$this$generate_u24lambda_u244":Landroid/graphics/Paint;
    const/4 v13, 0x0

    .line 62
    .local v13, "$i$a$-apply-AiVisionPdfGenerator$generate$sectionPaint$1":I
    const/16 v2, 0x30

    const/16 v14, 0x26

    invoke-static {v14, v2, v15}, Landroid/graphics/Color;->rgb(III)I

    move-result v2

    invoke-virtual {v12, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 63
    const/high16 v2, 0x41300000    # 11.0f

    invoke-virtual {v12, v2}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 64
    sget-object v2, Landroid/graphics/Typeface;->DEFAULT:Landroid/graphics/Typeface;

    const/4 v14, 0x1

    invoke-static {v2, v14}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;I)Landroid/graphics/Typeface;

    move-result-object v2

    invoke-virtual {v12, v2}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 65
    nop

    .line 61
    .end local v12    # "$this$generate_u24lambda_u244":Landroid/graphics/Paint;
    .end local v13    # "$i$a$-apply-AiVisionPdfGenerator$generate$sectionPaint$1":I
    move-object/from16 v35, v0

    .line 66
    .local v35, "sectionPaint":Landroid/graphics/Paint;
    new-instance v41, Landroid/graphics/Paint;

    invoke-direct/range {v41 .. v41}, Landroid/graphics/Paint;-><init>()V

    move-object/from16 v0, v41

    .local v0, "$this$generate_u24lambda_u245":Landroid/graphics/Paint;
    const/4 v2, 0x0

    .line 67
    .local v2, "$i$a$-apply-AiVisionPdfGenerator$generate$dividerPaint$1":I
    const/16 v12, 0xe0

    const/16 v13, 0xe6

    const/16 v14, 0xda

    invoke-static {v14, v12, v13}, Landroid/graphics/Color;->rgb(III)I

    move-result v12

    invoke-virtual {v0, v12}, Landroid/graphics/Paint;->setColor(I)V

    .line 68
    const/high16 v12, 0x3f800000    # 1.0f

    invoke-virtual {v0, v12}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 69
    nop

    .line 66
    .end local v0    # "$this$generate_u24lambda_u245":Landroid/graphics/Paint;
    .end local v2    # "$i$a$-apply-AiVisionPdfGenerator$generate$dividerPaint$1":I
    nop

    .line 113
    .local v41, "dividerPaint":Landroid/graphics/Paint;
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v2, "yyyy-MM-dd HH:mm:ss"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v12

    invoke-direct {v0, v2, v12}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    move-object v2, v0

    .line 114
    .local v2, "formatter":Ljava/text/SimpleDateFormat;
    move-object v0, v9

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$sortedBy$iv":Ljava/lang/Iterable;
    const/4 v12, 0x0

    .line 241
    .local v12, "$i$f$sortedBy":I
    new-instance v13, Lcom/rokid/phone/ai/AiVisionPdfGenerator$generate$$inlined$sortedBy$1;

    invoke-direct {v13}, Lcom/rokid/phone/ai/AiVisionPdfGenerator$generate$$inlined$sortedBy$1;-><init>()V

    check-cast v13, Ljava/util/Comparator;

    invoke-static {v0, v13}, Lkotlin/collections/CollectionsKt;->sortedWith(Ljava/lang/Iterable;Ljava/util/Comparator;)Ljava/util/List;

    move-result-object v0

    .line 114
    .end local v0    # "$this$sortedBy$iv":Ljava/lang/Iterable;
    .end local v12    # "$i$f$sortedBy":I
    move-object/from16 v42, v0

    .line 115
    .local v42, "orderedRecords":Ljava/util/List;
    invoke-static/range {v42 .. v42}, Lkotlin/collections/CollectionsKt;->asReversed(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .line 116
    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->asSequence(Ljava/lang/Iterable;)Lkotlin/sequences/Sequence;

    move-result-object v0

    .line 117
    new-instance v12, Lcom/rokid/phone/ai/AiVisionPdfGenerator$generate$reportTitle$1;

    sget-object v13, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->INSTANCE:Lcom/rokid/phone/ai/AiVisionAnswerPolicy;

    invoke-direct {v12, v13}, Lcom/rokid/phone/ai/AiVisionPdfGenerator$generate$reportTitle$1;-><init>(Ljava/lang/Object;)V

    check-cast v12, Lkotlin/jvm/functions/Function1;

    invoke-static {v0, v12}, Lkotlin/sequences/SequencesKt;->map(Lkotlin/sequences/Sequence;Lkotlin/jvm/functions/Function1;)Lkotlin/sequences/Sequence;

    move-result-object v0

    .line 118
    nop

    .local v0, "$this$firstOrNull$iv":Lkotlin/sequences/Sequence;
    const/4 v12, 0x0

    .line 242
    .local v12, "$i$f$firstOrNull":I
    invoke-interface {v0}, Lkotlin/sequences/Sequence;->iterator()Ljava/util/Iterator;

    move-result-object v13

    :cond_0
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v14

    if-eqz v14, :cond_1

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v14

    .local v14, "element$iv":Ljava/lang/Object;
    move-object/from16 v16, v14

    check-cast v16, Ljava/lang/String;

    .local v16, "p0":Ljava/lang/String;
    const/16 v17, 0x0

    .line 118
    .local v17, "$i$a$-firstOrNull-AiVisionPdfGenerator$generate$reportTitle$2":I
    move-object/from16 v19, v16

    check-cast v19, Ljava/lang/CharSequence;

    invoke-static/range {v19 .. v19}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v19

    const/16 v21, 0x1

    xor-int/lit8 v19, v19, 0x1

    .line 242
    .end local v16    # "p0":Ljava/lang/String;
    .end local v17    # "$i$a$-firstOrNull-AiVisionPdfGenerator$generate$reportTitle$2":I
    if-eqz v19, :cond_0

    goto :goto_0

    .line 243
    .end local v14    # "element$iv":Ljava/lang/Object;
    :cond_1
    const/4 v14, 0x0

    .line 118
    .end local v0    # "$this$firstOrNull$iv":Lkotlin/sequences/Sequence;
    .end local v12    # "$i$f$firstOrNull":I
    :goto_0
    check-cast v14, Ljava/lang/String;

    .line 115
    const-string v0, "getString(...)"

    if-nez v14, :cond_2

    .line 119
    nop

    .line 120
    sget v12, Lcom/rokid/phone/R$string;->demo_ai_vision_report_title:I

    .line 121
    new-instance v13, Ljava/text/SimpleDateFormat;

    const-string v14, "yyyy-MM-dd"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v15

    invoke-direct {v13, v14, v15}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v14, Ljava/util/Date;

    invoke-direct {v14, v10, v11}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v13, v14}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v13

    filled-new-array {v13}, [Ljava/lang/Object;

    move-result-object v13

    .line 119
    invoke-virtual {v8, v12, v13}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object/from16 v17, v12

    goto :goto_1

    .line 115
    :cond_2
    move-object/from16 v17, v14

    :goto_1
    nop

    .line 123
    .local v17, "reportTitle":Ljava/lang/String;
    const/high16 v19, 0x41000000    # 8.0f

    move-object v12, v3

    move-object v13, v4

    move-object v14, v7

    const/4 v9, 0x0

    move-object v15, v5

    move-object/from16 v16, v6

    invoke-static/range {v12 .. v19}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate$drawParagraph(Lkotlin/jvm/internal/Ref$FloatRef;Lkotlin/jvm/internal/Ref$ObjectRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Landroid/graphics/Paint;F)V

    .line 124
    iget-object v12, v4, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v12, Landroid/graphics/Canvas;

    .line 125
    nop

    .line 126
    sget v13, Lcom/rokid/phone/R$string;->demo_ai_vision_report_generated_at:I

    .line 127
    new-instance v14, Ljava/util/Date;

    invoke-direct {v14, v10, v11}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v2, v14}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v14

    filled-new-array {v14}, [Ljava/lang/Object;

    move-result-object v14

    .line 125
    invoke-virtual {v8, v13, v14}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v13

    .line 129
    nop

    .line 130
    iget v14, v3, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    invoke-virtual {v1}, Landroid/graphics/Paint;->getTextSize()F

    move-result v15

    add-float/2addr v14, v15

    .line 131
    nop

    .line 124
    const/high16 v15, 0x42100000    # 36.0f

    invoke-virtual {v12, v13, v15, v14, v1}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 133
    iget v12, v3, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    invoke-virtual {v1}, Landroid/graphics/Paint;->getTextSize()F

    move-result v13

    const/high16 v14, 0x41400000    # 12.0f

    add-float/2addr v13, v14

    add-float/2addr v12, v13

    iput v12, v3, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    .line 134
    move-object/from16 v12, v42

    check-cast v12, Ljava/lang/Iterable;

    .local v12, "$this$mapNotNull$iv":Ljava/lang/Iterable;
    const/4 v13, 0x0

    .line 244
    .local v13, "$i$f$mapNotNull":I
    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14}, Ljava/util/ArrayList;-><init>()V

    check-cast v14, Ljava/util/Collection;

    .local v14, "destination$iv$iv":Ljava/util/Collection;
    move-object v15, v12

    .local v15, "$this$mapNotNullTo$iv$iv":Ljava/lang/Iterable;
    const/16 v16, 0x0

    .line 252
    .local v16, "$i$f$mapNotNullTo":I
    move-object/from16 v19, v15

    .local v19, "$this$forEach$iv$iv$iv":Ljava/lang/Iterable;
    const/16 v20, 0x0

    .line 253
    .local v20, "$i$f$forEach":I
    invoke-interface/range {v19 .. v19}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v22

    :goto_2
    invoke-interface/range {v22 .. v22}, Ljava/util/Iterator;->hasNext()Z

    move-result v23

    if-eqz v23, :cond_5

    invoke-interface/range {v22 .. v22}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v23

    .local v23, "element$iv$iv$iv":Ljava/lang/Object;
    move-object/from16 v24, v23

    .local v24, "element$iv$iv":Ljava/lang/Object;
    const/16 v25, 0x0

    .line 252
    .local v25, "$i$a$-forEach-CollectionsKt___CollectionsKt$mapNotNullTo$1$iv$iv":I
    move-object/from16 v9, v24

    check-cast v9, Lcom/rokid/phone/ai/AiVisionRecord;

    .local v9, "record":Lcom/rokid/phone/ai/AiVisionRecord;
    const/16 v27, 0x0

    .line 135
    .local v27, "$i$a$-mapNotNull-AiVisionPdfGenerator$generate$reportSummary$1":I
    move-object/from16 v28, v2

    .end local v2    # "formatter":Ljava/text/SimpleDateFormat;
    .local v28, "formatter":Ljava/text/SimpleDateFormat;
    sget-object v2, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->INSTANCE:Lcom/rokid/phone/ai/AiVisionAnswerPolicy;

    invoke-virtual {v2, v9}, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->resolveReportSummary(Lcom/rokid/phone/ai/AiVisionRecord;)Ljava/lang/String;

    move-result-object v2

    move-object/from16 v29, v2

    .line 240
    .local v29, "it":Ljava/lang/String;
    const/16 v30, 0x0

    .line 135
    .local v30, "$i$a$-takeIf-AiVisionPdfGenerator$generate$reportSummary$1$1":I
    move-object/from16 v31, v29

    check-cast v31, Ljava/lang/CharSequence;

    invoke-static/range {v31 .. v31}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v31

    const/16 v21, 0x1

    xor-int/lit8 v31, v31, 0x1

    .end local v29    # "it":Ljava/lang/String;
    .end local v30    # "$i$a$-takeIf-AiVisionPdfGenerator$generate$reportSummary$1$1":I
    if-eqz v31, :cond_3

    goto :goto_3

    :cond_3
    const/4 v2, 0x0

    .line 252
    .end local v9    # "record":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v27    # "$i$a$-mapNotNull-AiVisionPdfGenerator$generate$reportSummary$1":I
    :goto_3
    if-eqz v2, :cond_4

    .line 254
    .local v2, "it$iv$iv":Ljava/lang/Object;
    const/4 v9, 0x0

    .line 252
    .local v9, "$i$a$-let-CollectionsKt___CollectionsKt$mapNotNullTo$1$1$iv$iv":I
    invoke-interface {v14, v2}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    .line 253
    .end local v2    # "it$iv$iv":Ljava/lang/Object;
    .end local v9    # "$i$a$-let-CollectionsKt___CollectionsKt$mapNotNullTo$1$1$iv$iv":I
    .end local v24    # "element$iv$iv":Ljava/lang/Object;
    .end local v25    # "$i$a$-forEach-CollectionsKt___CollectionsKt$mapNotNullTo$1$iv$iv":I
    :cond_4
    move-object/from16 v2, v28

    const/4 v9, 0x0

    .end local v23    # "element$iv$iv$iv":Ljava/lang/Object;
    goto :goto_2

    .line 255
    .end local v28    # "formatter":Ljava/text/SimpleDateFormat;
    .local v2, "formatter":Ljava/text/SimpleDateFormat;
    :cond_5
    move-object/from16 v28, v2

    .line 256
    .end local v2    # "formatter":Ljava/text/SimpleDateFormat;
    .end local v19    # "$this$forEach$iv$iv$iv":Ljava/lang/Iterable;
    .end local v20    # "$i$f$forEach":I
    .restart local v28    # "formatter":Ljava/text/SimpleDateFormat;
    nop

    .end local v14    # "destination$iv$iv":Ljava/util/Collection;
    .end local v15    # "$this$mapNotNullTo$iv$iv":Ljava/lang/Iterable;
    .end local v16    # "$i$f$mapNotNullTo":I
    move-object v2, v14

    check-cast v2, Ljava/util/List;

    .line 244
    nop

    .end local v12    # "$this$mapNotNull$iv":Ljava/lang/Iterable;
    .end local v13    # "$i$f$mapNotNull":I
    check-cast v2, Ljava/lang/Iterable;

    .line 136
    invoke-static {v2}, Lkotlin/collections/CollectionsKt;->distinct(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v2

    move-object/from16 v43, v2

    check-cast v43, Ljava/lang/Iterable;

    const-string v2, "\n"

    move-object/from16 v44, v2

    check-cast v44, Ljava/lang/CharSequence;

    const/16 v50, 0x3e

    const/16 v51, 0x0

    const/16 v45, 0x0

    const/16 v46, 0x0

    const/16 v47, 0x0

    const/16 v48, 0x0

    const/16 v49, 0x0

    invoke-static/range {v43 .. v51}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 134
    move-object v9, v2

    .line 137
    .local v9, "reportSummary":Ljava/lang/String;
    move-object v2, v9

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    const/4 v12, 0x1

    xor-int/2addr v2, v12

    if-eqz v2, :cond_6

    .line 138
    nop

    .line 139
    sget v2, Lcom/rokid/phone/R$string;->demo_ai_vision_report_summary:I

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v12

    invoke-virtual {v8, v2, v12}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 140
    nop

    .line 141
    nop

    .line 138
    const/high16 v27, 0x40800000    # 4.0f

    move-object/from16 v20, v3

    move-object/from16 v21, v4

    move-object/from16 v22, v7

    move-object/from16 v23, v5

    move-object/from16 v24, v6

    move-object/from16 v25, v2

    invoke-static/range {v20 .. v27}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate$drawParagraph(Lkotlin/jvm/internal/Ref$FloatRef;Lkotlin/jvm/internal/Ref$ObjectRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Landroid/graphics/Paint;F)V

    .line 144
    :cond_6
    iget-object v2, v4, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object/from16 v36, v2

    check-cast v36, Landroid/graphics/Canvas;

    iget v2, v3, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    const v39, 0x440bc000    # 559.0f

    iget v12, v3, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    const/high16 v37, 0x42100000    # 36.0f

    move/from16 v38, v2

    move/from16 v40, v12

    invoke-virtual/range {v36 .. v41}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 145
    iget v2, v3, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    const/high16 v12, 0x41900000    # 18.0f

    add-float/2addr v2, v12

    iput v2, v3, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    .line 147
    move-object/from16 v12, v42

    check-cast v12, Ljava/lang/Iterable;

    .local v12, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v13, 0x0

    .line 257
    .local v13, "$i$f$forEach":I
    invoke-interface {v12}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v14

    :goto_4
    invoke-interface {v14}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_9

    invoke-interface {v14}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v15

    .local v15, "element$iv":Ljava/lang/Object;
    move-object/from16 v16, v15

    check-cast v16, Lcom/rokid/phone/ai/AiVisionRecord;

    .local v16, "record":Lcom/rokid/phone/ai/AiVisionRecord;
    const/16 v19, 0x0

    .line 148
    .local v19, "$i$a$-forEach-AiVisionPdfGenerator$generate$2":I
    const/high16 v20, 0x428c0000    # 70.0f

    move-object/from16 v21, v9

    move-object/from16 v9, v28

    .end local v28    # "formatter":Ljava/text/SimpleDateFormat;
    .local v9, "formatter":Ljava/text/SimpleDateFormat;
    .local v21, "reportSummary":Ljava/lang/String;
    move-object v2, v3

    move-object/from16 v22, v3

    .end local v3    # "y":Lkotlin/jvm/internal/Ref$FloatRef;
    .local v22, "y":Lkotlin/jvm/internal/Ref$FloatRef;
    move-object v3, v7

    move-object/from16 v23, v4

    .end local v4    # "canvas":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local v23, "canvas":Lkotlin/jvm/internal/Ref$ObjectRef;
    move-object v4, v5

    move-object/from16 v24, v5

    .end local v5    # "page":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local v24, "page":Lkotlin/jvm/internal/Ref$ObjectRef;
    move-object v5, v6

    move-object/from16 v25, v6

    .end local v6    # "pageNumber":Lkotlin/jvm/internal/Ref$IntRef;
    .local v25, "pageNumber":Lkotlin/jvm/internal/Ref$IntRef;
    move-object/from16 v6, v23

    move-object/from16 v36, v7

    .end local v7    # "document":Landroid/graphics/pdf/PdfDocument;
    .local v36, "document":Landroid/graphics/pdf/PdfDocument;
    move/from16 v7, v20

    invoke-static/range {v2 .. v7}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate$ensureSpace(Lkotlin/jvm/internal/Ref$FloatRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/jvm/internal/Ref$ObjectRef;F)V

    .line 149
    nop

    .line 150
    nop

    .line 151
    sget v2, Lcom/rokid/phone/R$string;->demo_ai_vision_report_time:I

    .line 152
    new-instance v3, Ljava/util/Date;

    invoke-virtual/range {v16 .. v16}, Lcom/rokid/phone/ai/AiVisionRecord;->getTimestamp()J

    move-result-wide v4

    invoke-direct {v3, v4, v5}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v9, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    .line 150
    invoke-virtual {v8, v2, v3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 154
    nop

    .line 155
    nop

    .line 149
    const/high16 v34, 0x40400000    # 3.0f

    move-object/from16 v27, v22

    move-object/from16 v28, v23

    move-object/from16 v29, v36

    move-object/from16 v30, v24

    move-object/from16 v31, v25

    move-object/from16 v32, v2

    move-object/from16 v33, v1

    invoke-static/range {v27 .. v34}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate$drawParagraph(Lkotlin/jvm/internal/Ref$FloatRef;Lkotlin/jvm/internal/Ref$ObjectRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Landroid/graphics/Paint;F)V

    .line 157
    move-object/from16 v20, v1

    .end local v1    # "smallPaint":Landroid/graphics/Paint;
    .local v20, "smallPaint":Landroid/graphics/Paint;
    move-object/from16 v1, p1

    move-object/from16 v2, v23

    move-object/from16 v3, v22

    move-object/from16 v4, v36

    move-object/from16 v5, v24

    move-object/from16 v6, v25

    move-object/from16 v7, v16

    invoke-static/range {v1 .. v7}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate$drawImage(Landroid/content/Context;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$FloatRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Lcom/rokid/phone/ai/AiVisionRecord;)V

    .line 158
    nop

    .line 159
    nop

    .line 160
    sget v1, Lcom/rokid/phone/R$string;->demo_ai_vision_report_question:I

    .line 161
    invoke-virtual/range {v16 .. v16}, Lcom/rokid/phone/ai/AiVisionRecord;->getQuestion()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_7

    const/4 v2, 0x0

    .line 162
    .local v2, "$i$a$-ifBlank-AiVisionPdfGenerator$generate$2$1":I
    sget v3, Lcom/rokid/phone/R$string;->demo_ai_vision_unknown_question:I

    invoke-virtual {v8, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 161
    .end local v2    # "$i$a$-ifBlank-AiVisionPdfGenerator$generate$2$1":I
    move-object v2, v3

    :cond_7
    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    .line 159
    invoke-virtual {v8, v1, v2}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 165
    nop

    .line 166
    nop

    .line 158
    const/high16 v34, 0x40800000    # 4.0f

    move-object/from16 v27, v22

    move-object/from16 v28, v23

    move-object/from16 v29, v36

    move-object/from16 v30, v24

    move-object/from16 v31, v25

    move-object/from16 v32, v1

    move-object/from16 v33, v26

    invoke-static/range {v27 .. v34}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate$drawParagraph(Lkotlin/jvm/internal/Ref$FloatRef;Lkotlin/jvm/internal/Ref$ObjectRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Landroid/graphics/Paint;F)V

    .line 168
    nop

    .line 169
    nop

    .line 170
    sget v1, Lcom/rokid/phone/R$string;->demo_ai_vision_report_answer:I

    .line 171
    invoke-virtual/range {v16 .. v16}, Lcom/rokid/phone/ai/AiVisionRecord;->getAnswer()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_8

    const/4 v2, 0x0

    .line 172
    .local v2, "$i$a$-ifBlank-AiVisionPdfGenerator$generate$2$2":I
    sget v3, Lcom/rokid/phone/R$string;->demo_ai_vision_no_answer:I

    invoke-virtual {v8, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 171
    .end local v2    # "$i$a$-ifBlank-AiVisionPdfGenerator$generate$2$2":I
    move-object v2, v3

    :cond_8
    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    .line 169
    invoke-virtual {v8, v1, v2}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 175
    nop

    .line 176
    nop

    .line 168
    const/high16 v34, 0x41000000    # 8.0f

    move-object/from16 v27, v22

    move-object/from16 v28, v23

    move-object/from16 v29, v36

    move-object/from16 v30, v24

    move-object/from16 v31, v25

    move-object/from16 v32, v1

    move-object/from16 v33, v26

    invoke-static/range {v27 .. v34}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate$drawParagraph(Lkotlin/jvm/internal/Ref$FloatRef;Lkotlin/jvm/internal/Ref$ObjectRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Ljava/lang/String;Landroid/graphics/Paint;F)V

    .line 178
    const/high16 v7, 0x41200000    # 10.0f

    move-object/from16 v2, v22

    move-object/from16 v3, v36

    move-object/from16 v4, v24

    move-object/from16 v5, v25

    move-object/from16 v6, v23

    invoke-static/range {v2 .. v7}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate$ensureSpace(Lkotlin/jvm/internal/Ref$FloatRef;Landroid/graphics/pdf/PdfDocument;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/jvm/internal/Ref$ObjectRef;F)V

    .line 179
    move-object/from16 v1, v23

    .end local v23    # "canvas":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local v1, "canvas":Lkotlin/jvm/internal/Ref$ObjectRef;
    iget-object v2, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object/from16 v27, v2

    check-cast v27, Landroid/graphics/Canvas;

    move-object/from16 v2, v22

    .end local v22    # "y":Lkotlin/jvm/internal/Ref$FloatRef;
    .local v2, "y":Lkotlin/jvm/internal/Ref$FloatRef;
    iget v3, v2, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    const v30, 0x440bc000    # 559.0f

    iget v4, v2, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    const/high16 v28, 0x42100000    # 36.0f

    move/from16 v29, v3

    move/from16 v31, v4

    move-object/from16 v32, v41

    invoke-virtual/range {v27 .. v32}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 180
    iget v3, v2, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    const/high16 v4, 0x41800000    # 16.0f

    add-float/2addr v3, v4

    iput v3, v2, Lkotlin/jvm/internal/Ref$FloatRef;->element:F

    .line 181
    nop

    .line 257
    .end local v16    # "record":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v19    # "$i$a$-forEach-AiVisionPdfGenerator$generate$2":I
    move-object v4, v1

    move-object v3, v2

    move-object/from16 v28, v9

    move-object/from16 v1, v20

    move-object/from16 v9, v21

    move-object/from16 v5, v24

    move-object/from16 v6, v25

    move-object/from16 v7, v36

    .end local v15    # "element$iv":Ljava/lang/Object;
    goto/16 :goto_4

    .line 258
    .end local v2    # "y":Lkotlin/jvm/internal/Ref$FloatRef;
    .end local v20    # "smallPaint":Landroid/graphics/Paint;
    .end local v21    # "reportSummary":Ljava/lang/String;
    .end local v24    # "page":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v25    # "pageNumber":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v36    # "document":Landroid/graphics/pdf/PdfDocument;
    .local v1, "smallPaint":Landroid/graphics/Paint;
    .restart local v3    # "y":Lkotlin/jvm/internal/Ref$FloatRef;
    .restart local v4    # "canvas":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v5    # "page":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v6    # "pageNumber":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v7    # "document":Landroid/graphics/pdf/PdfDocument;
    .local v9, "reportSummary":Ljava/lang/String;
    .restart local v28    # "formatter":Ljava/text/SimpleDateFormat;
    :cond_9
    move-object/from16 v20, v1

    move-object v2, v3

    move-object v1, v4

    move-object/from16 v24, v5

    move-object/from16 v25, v6

    move-object/from16 v36, v7

    move-object/from16 v21, v9

    move-object/from16 v9, v28

    .line 182
    .end local v3    # "y":Lkotlin/jvm/internal/Ref$FloatRef;
    .end local v4    # "canvas":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v5    # "page":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v6    # "pageNumber":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v7    # "document":Landroid/graphics/pdf/PdfDocument;
    .end local v12    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v13    # "$i$f$forEach":I
    .end local v28    # "formatter":Ljava/text/SimpleDateFormat;
    .local v1, "canvas":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v2    # "y":Lkotlin/jvm/internal/Ref$FloatRef;
    .local v9, "formatter":Ljava/text/SimpleDateFormat;
    .restart local v20    # "smallPaint":Landroid/graphics/Paint;
    .restart local v21    # "reportSummary":Ljava/lang/String;
    .restart local v24    # "page":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v25    # "pageNumber":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v36    # "document":Landroid/graphics/pdf/PdfDocument;
    move-object/from16 v3, v24

    .end local v24    # "page":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local v3, "page":Lkotlin/jvm/internal/Ref$ObjectRef;
    iget-object v4, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v4, Landroid/graphics/pdf/PdfDocument$Page;

    move-object/from16 v5, v36

    .end local v36    # "document":Landroid/graphics/pdf/PdfDocument;
    .local v5, "document":Landroid/graphics/pdf/PdfDocument;
    invoke-virtual {v5, v4}, Landroid/graphics/pdf/PdfDocument;->finishPage(Landroid/graphics/pdf/PdfDocument$Page;)V

    .line 184
    new-instance v4, Ljava/text/SimpleDateFormat;

    const-string v6, "yyyyMMdd_HHmmss"

    sget-object v7, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-direct {v4, v6, v7}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v6, Ljava/util/Date;

    invoke-direct {v6, v10, v11}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v4, v6}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v4

    .line 185
    .local v4, "stamp":Ljava/lang/String;
    new-instance v6, Ljava/io/File;

    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v7

    const-string v12, "ai-vision-reports"

    invoke-direct {v6, v7, v12}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    move-object v7, v6

    .line 240
    .local v7, "$this$generate_u24lambda_u2414":Ljava/io/File;
    const/4 v12, 0x0

    .line 185
    .local v12, "$i$a$-apply-AiVisionPdfGenerator$generate$directory$1":I
    invoke-virtual {v7}, Ljava/io/File;->mkdirs()Z

    .line 186
    .end local v7    # "$this$generate_u24lambda_u2414":Ljava/io/File;
    .end local v12    # "$i$a$-apply-AiVisionPdfGenerator$generate$directory$1":I
    .local v6, "directory":Ljava/io/File;
    new-instance v7, Ljava/io/File;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "ai_vision_report_"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, ".pdf"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-direct {v7, v6, v12}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 187
    .local v7, "file":Ljava/io/File;
    new-instance v12, Ljava/io/FileOutputStream;

    invoke-direct {v12, v7}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    check-cast v12, Ljava/io/Closeable;

    :try_start_0
    move-object v13, v12

    check-cast v13, Ljava/io/OutputStream;

    .line 240
    .local v13, "p0":Ljava/io/OutputStream;
    const/4 v14, 0x0

    .line 187
    .local v14, "$i$a$-use-AiVisionPdfGenerator$generate$3":I
    invoke-virtual {v5, v13}, Landroid/graphics/pdf/PdfDocument;->writeTo(Ljava/io/OutputStream;)V

    .end local v13    # "p0":Ljava/io/OutputStream;
    .end local v14    # "$i$a$-use-AiVisionPdfGenerator$generate$3":I
    sget-object v13, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v13, 0x0

    invoke-static {v12, v13}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 188
    invoke-virtual {v5}, Landroid/graphics/pdf/PdfDocument;->close()V

    .line 189
    sget v12, Lcom/rokid/phone/R$string;->demo_ai_vision_report_file_name:I

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v13

    invoke-virtual {v8, v12, v13}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v0, v12

    .line 190
    .local v0, "displayName":Ljava/lang/String;
    new-instance v12, Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

    invoke-direct {v12, v7, v0}, Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v12

    .line 187
    .end local v0    # "displayName":Ljava/lang/String;
    :catchall_0
    move-exception v0

    move-object v13, v0

    .end local v1    # "canvas":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v2    # "y":Lkotlin/jvm/internal/Ref$FloatRef;
    .end local v3    # "page":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v4    # "stamp":Ljava/lang/String;
    .end local v5    # "document":Landroid/graphics/pdf/PdfDocument;
    .end local v6    # "directory":Ljava/io/File;
    .end local v7    # "file":Ljava/io/File;
    .end local v9    # "formatter":Ljava/text/SimpleDateFormat;
    .end local v17    # "reportTitle":Ljava/lang/String;
    .end local v18    # "titlePaint":Landroid/graphics/Paint;
    .end local v20    # "smallPaint":Landroid/graphics/Paint;
    .end local v21    # "reportSummary":Ljava/lang/String;
    .end local v25    # "pageNumber":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v26    # "bodyPaint":Landroid/graphics/Paint;
    .end local v35    # "sectionPaint":Landroid/graphics/Paint;
    .end local v41    # "dividerPaint":Landroid/graphics/Paint;
    .end local v42    # "orderedRecords":Ljava/util/List;
    .end local p1    # "context":Landroid/content/Context;
    .end local p2    # "records":Ljava/util/List;
    .end local p3    # "generatedAt":J
    :try_start_1
    throw v13
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .restart local v1    # "canvas":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v2    # "y":Lkotlin/jvm/internal/Ref$FloatRef;
    .restart local v3    # "page":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v4    # "stamp":Ljava/lang/String;
    .restart local v5    # "document":Landroid/graphics/pdf/PdfDocument;
    .restart local v6    # "directory":Ljava/io/File;
    .restart local v7    # "file":Ljava/io/File;
    .restart local v9    # "formatter":Ljava/text/SimpleDateFormat;
    .restart local v17    # "reportTitle":Ljava/lang/String;
    .restart local v18    # "titlePaint":Landroid/graphics/Paint;
    .restart local v20    # "smallPaint":Landroid/graphics/Paint;
    .restart local v21    # "reportSummary":Ljava/lang/String;
    .restart local v25    # "pageNumber":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v26    # "bodyPaint":Landroid/graphics/Paint;
    .restart local v35    # "sectionPaint":Landroid/graphics/Paint;
    .restart local v41    # "dividerPaint":Landroid/graphics/Paint;
    .restart local v42    # "orderedRecords":Ljava/util/List;
    .restart local p1    # "context":Landroid/content/Context;
    .restart local p2    # "records":Ljava/util/List;
    .restart local p3    # "generatedAt":J
    :catchall_1
    move-exception v0

    move-object v14, v0

    invoke-static {v12, v13}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    throw v14

    .line 240
    .end local v1    # "canvas":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v2    # "y":Lkotlin/jvm/internal/Ref$FloatRef;
    .end local v3    # "page":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v4    # "stamp":Ljava/lang/String;
    .end local v5    # "document":Landroid/graphics/pdf/PdfDocument;
    .end local v6    # "directory":Ljava/io/File;
    .end local v7    # "file":Ljava/io/File;
    .end local v9    # "formatter":Ljava/text/SimpleDateFormat;
    .end local v17    # "reportTitle":Ljava/lang/String;
    .end local v18    # "titlePaint":Landroid/graphics/Paint;
    .end local v20    # "smallPaint":Landroid/graphics/Paint;
    .end local v21    # "reportSummary":Ljava/lang/String;
    .end local v25    # "pageNumber":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v26    # "bodyPaint":Landroid/graphics/Paint;
    .end local v35    # "sectionPaint":Landroid/graphics/Paint;
    .end local v41    # "dividerPaint":Landroid/graphics/Paint;
    .end local v42    # "orderedRecords":Ljava/util/List;
    :cond_a
    const/4 v0, 0x0

    .line 39
    .local v0, "$i$a$-require-AiVisionPdfGenerator$generate$1":I
    nop

    .end local v0    # "$i$a$-require-AiVisionPdfGenerator$generate$1":I
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "No recognition records"

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
