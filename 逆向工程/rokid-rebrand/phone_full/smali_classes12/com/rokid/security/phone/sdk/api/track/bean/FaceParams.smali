.class public Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;
.super Ljava/lang/Object;
.source "FaceParams.java"


# static fields
.field public static FACE_LOCKING_INTERVAL:I = 0x0

.field public static FACE_LOCKING_SEND_INTERVA:I = 0x0

.field private static final HEIGHT_1080P:I = 0x780

.field private static final HEIGHT_1440P:I = 0x5a0

.field private static final HEIGHT_2K:I = 0x600

.field private static final HEIGHT_720P:I = 0x2d0

.field public static PREVIEW_HEIGHT:I = 0x0

.field public static PREVIEW_WIDTH:I = 0x0

.field private static final WIDTH_1080P:I = 0x438

.field private static final WIDTH_1440P:I = 0x780

.field private static final WIDTH_2K:I = 0x800

.field private static final WIDTH_720P:I = 0x500

.field public static final cropScale:F = 1.6f

.field public static final glassRoiRectF:Landroid/graphics/RectF;

.field public static isGlass:Z = false

.field public static final plateRoiRectF:Landroid/graphics/RectF;

.field public static final roiScale:F = 1.5f


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 8
    const/4 v0, 0x1

    sput-boolean v0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->isGlass:Z

    .line 25
    const/16 v0, 0x500

    sput v0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_WIDTH:I

    .line 26
    const/16 v0, 0x2d0

    sput v0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_HEIGHT:I

    .line 28
    const/16 v0, 0xfa0

    sput v0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->FACE_LOCKING_INTERVAL:I

    .line 29
    const/16 v0, 0x7d0

    sput v0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->FACE_LOCKING_SEND_INTERVA:I

    .line 31
    new-instance v0, Landroid/graphics/RectF;

    const/high16 v1, 0x3ea00000    # 0.3125f

    const v2, 0x3edc71c7

    const/high16 v3, 0x3f0c0000    # 0.546875f

    const v4, 0x3f58e38e

    invoke-direct {v0, v1, v2, v3, v4}, Landroid/graphics/RectF;-><init>(FFFF)V

    sput-object v0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->glassRoiRectF:Landroid/graphics/RectF;

    .line 32
    new-instance v0, Landroid/graphics/RectF;

    const/high16 v1, 0x3e700000    # 0.234375f

    const/high16 v3, 0x3f200000    # 0.625f

    invoke-direct {v0, v1, v2, v3, v4}, Landroid/graphics/RectF;-><init>(FFFF)V

    sput-object v0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->plateRoiRectF:Landroid/graphics/RectF;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
