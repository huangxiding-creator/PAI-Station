.class public Lcom/rokid/aicore/ncnn/bean/MotBBox;
.super Ljava/lang/Object;
.source "MotBBox.java"


# instance fields
.field public x1:F

.field public x2:F

.field public y1:F

.field public y2:F


# direct methods
.method public constructor <init>(FFFF)V
    .locals 0
    .param p1, "x1"    # F
    .param p2, "y1"    # F
    .param p3, "x2"    # F
    .param p4, "y2"    # F

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 11
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x1:F

    .line 12
    iput p2, p0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y1:F

    .line 13
    iput p3, p0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x2:F

    .line 14
    iput p4, p0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y2:F

    .line 15
    return-void
.end method
