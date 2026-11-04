.class Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;
.super Ljava/lang/Object;
.source "SpanUtils.java"

# interfaces
.implements Landroid/text/style/LineHeightSpan;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blankj/utilcode/util/SpanUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "CustomLineHeightSpan"
.end annotation


# static fields
.field static final ALIGN_CENTER:I = 0x2

.field static final ALIGN_TOP:I = 0x3

.field static sfm:Landroid/graphics/Paint$FontMetricsInt;


# instance fields
.field private final height:I

.field final mVerticalAlignment:I


# direct methods
.method constructor <init>(II)V
    .locals 0
    .param p1, "height"    # I
    .param p2, "verticalAlignment"    # I

    .line 1052
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1053
    iput p1, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->height:I

    .line 1054
    iput p2, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->mVerticalAlignment:I

    .line 1055
    return-void
.end method


# virtual methods
.method public chooseHeight(Ljava/lang/CharSequence;IIIILandroid/graphics/Paint$FontMetricsInt;)V
    .locals 6
    .param p1, "text"    # Ljava/lang/CharSequence;
    .param p2, "start"    # I
    .param p3, "end"    # I
    .param p4, "spanstartv"    # I
    .param p5, "v"    # I
    .param p6, "fm"    # Landroid/graphics/Paint$FontMetricsInt;

    .line 1061
    sget-object v0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->sfm:Landroid/graphics/Paint$FontMetricsInt;

    if-nez v0, :cond_0

    .line 1062
    new-instance v0, Landroid/graphics/Paint$FontMetricsInt;

    invoke-direct {v0}, Landroid/graphics/Paint$FontMetricsInt;-><init>()V

    sput-object v0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->sfm:Landroid/graphics/Paint$FontMetricsInt;

    .line 1063
    sget-object v0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->sfm:Landroid/graphics/Paint$FontMetricsInt;

    iget v1, p6, Landroid/graphics/Paint$FontMetricsInt;->top:I

    iput v1, v0, Landroid/graphics/Paint$FontMetricsInt;->top:I

    .line 1064
    sget-object v0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->sfm:Landroid/graphics/Paint$FontMetricsInt;

    iget v1, p6, Landroid/graphics/Paint$FontMetricsInt;->ascent:I

    iput v1, v0, Landroid/graphics/Paint$FontMetricsInt;->ascent:I

    .line 1065
    sget-object v0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->sfm:Landroid/graphics/Paint$FontMetricsInt;

    iget v1, p6, Landroid/graphics/Paint$FontMetricsInt;->descent:I

    iput v1, v0, Landroid/graphics/Paint$FontMetricsInt;->descent:I

    .line 1066
    sget-object v0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->sfm:Landroid/graphics/Paint$FontMetricsInt;

    iget v1, p6, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    iput v1, v0, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    .line 1067
    sget-object v0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->sfm:Landroid/graphics/Paint$FontMetricsInt;

    iget v1, p6, Landroid/graphics/Paint$FontMetricsInt;->leading:I

    iput v1, v0, Landroid/graphics/Paint$FontMetricsInt;->leading:I

    goto :goto_0

    .line 1069
    :cond_0
    sget-object v0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->sfm:Landroid/graphics/Paint$FontMetricsInt;

    iget v0, v0, Landroid/graphics/Paint$FontMetricsInt;->top:I

    iput v0, p6, Landroid/graphics/Paint$FontMetricsInt;->top:I

    .line 1070
    sget-object v0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->sfm:Landroid/graphics/Paint$FontMetricsInt;

    iget v0, v0, Landroid/graphics/Paint$FontMetricsInt;->ascent:I

    iput v0, p6, Landroid/graphics/Paint$FontMetricsInt;->ascent:I

    .line 1071
    sget-object v0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->sfm:Landroid/graphics/Paint$FontMetricsInt;

    iget v0, v0, Landroid/graphics/Paint$FontMetricsInt;->descent:I

    iput v0, p6, Landroid/graphics/Paint$FontMetricsInt;->descent:I

    .line 1072
    sget-object v0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->sfm:Landroid/graphics/Paint$FontMetricsInt;

    iget v0, v0, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    iput v0, p6, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    .line 1073
    sget-object v0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->sfm:Landroid/graphics/Paint$FontMetricsInt;

    iget v0, v0, Landroid/graphics/Paint$FontMetricsInt;->leading:I

    iput v0, p6, Landroid/graphics/Paint$FontMetricsInt;->leading:I

    .line 1075
    :goto_0
    iget v0, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->height:I

    iget v1, p6, Landroid/graphics/Paint$FontMetricsInt;->descent:I

    add-int/2addr v1, p5

    iget v2, p6, Landroid/graphics/Paint$FontMetricsInt;->ascent:I

    sub-int/2addr v1, v2

    sub-int/2addr v1, p4

    sub-int/2addr v0, v1

    .line 1076
    .local v0, "need":I
    const/4 v1, 0x3

    const/4 v2, 0x2

    if-lez v0, :cond_3

    .line 1077
    iget v3, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->mVerticalAlignment:I

    if-ne v3, v1, :cond_1

    .line 1078
    iget v3, p6, Landroid/graphics/Paint$FontMetricsInt;->descent:I

    add-int/2addr v3, v0

    iput v3, p6, Landroid/graphics/Paint$FontMetricsInt;->descent:I

    goto :goto_1

    .line 1079
    :cond_1
    iget v3, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->mVerticalAlignment:I

    if-ne v3, v2, :cond_2

    .line 1080
    iget v3, p6, Landroid/graphics/Paint$FontMetricsInt;->descent:I

    div-int/lit8 v4, v0, 0x2

    add-int/2addr v3, v4

    iput v3, p6, Landroid/graphics/Paint$FontMetricsInt;->descent:I

    .line 1081
    iget v3, p6, Landroid/graphics/Paint$FontMetricsInt;->ascent:I

    div-int/lit8 v4, v0, 0x2

    sub-int/2addr v3, v4

    iput v3, p6, Landroid/graphics/Paint$FontMetricsInt;->ascent:I

    goto :goto_1

    .line 1083
    :cond_2
    iget v3, p6, Landroid/graphics/Paint$FontMetricsInt;->ascent:I

    sub-int/2addr v3, v0

    iput v3, p6, Landroid/graphics/Paint$FontMetricsInt;->ascent:I

    .line 1086
    :cond_3
    :goto_1
    iget v3, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->height:I

    iget v4, p6, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    add-int/2addr v4, p5

    iget v5, p6, Landroid/graphics/Paint$FontMetricsInt;->top:I

    sub-int/2addr v4, v5

    sub-int/2addr v4, p4

    sub-int/2addr v3, v4

    .line 1087
    .end local v0    # "need":I
    .local v3, "need":I
    if-lez v3, :cond_6

    .line 1088
    iget v0, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->mVerticalAlignment:I

    if-ne v0, v1, :cond_4

    .line 1089
    iget v0, p6, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    add-int/2addr v0, v3

    iput v0, p6, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    goto :goto_2

    .line 1090
    :cond_4
    iget v0, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->mVerticalAlignment:I

    if-ne v0, v2, :cond_5

    .line 1091
    iget v0, p6, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    div-int/lit8 v1, v3, 0x2

    add-int/2addr v0, v1

    iput v0, p6, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    .line 1092
    iget v0, p6, Landroid/graphics/Paint$FontMetricsInt;->top:I

    div-int/lit8 v1, v3, 0x2

    sub-int/2addr v0, v1

    iput v0, p6, Landroid/graphics/Paint$FontMetricsInt;->top:I

    goto :goto_2

    .line 1094
    :cond_5
    iget v0, p6, Landroid/graphics/Paint$FontMetricsInt;->top:I

    sub-int/2addr v0, v3

    iput v0, p6, Landroid/graphics/Paint$FontMetricsInt;->top:I

    .line 1097
    :cond_6
    :goto_2
    move-object v0, p1

    check-cast v0, Landroid/text/Spanned;

    invoke-interface {v0, p0}, Landroid/text/Spanned;->getSpanEnd(Ljava/lang/Object;)I

    move-result v0

    if-ne p3, v0, :cond_7

    .line 1098
    const/4 v0, 0x0

    sput-object v0, Lcom/blankj/utilcode/util/SpanUtils$CustomLineHeightSpan;->sfm:Landroid/graphics/Paint$FontMetricsInt;

    .line 1101
    :cond_7
    return-void
.end method
