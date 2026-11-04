.class public final Lcom/google/android/libraries/barhopper/MultiScaleDetectionOptions;
.super Ljava/lang/Object;
.source "com.google.mlkit:barcode-scanning@@17.3.0"


# instance fields
.field private extraScales:[F


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    new-array v0, v0, [F

    iput-object v0, p0, Lcom/google/android/libraries/barhopper/MultiScaleDetectionOptions;->extraScales:[F

    return-void
.end method


# virtual methods
.method public getExtraScales()[F
    .locals 1

    iget-object v0, p0, Lcom/google/android/libraries/barhopper/MultiScaleDetectionOptions;->extraScales:[F

    return-object v0
.end method

.method public setExtraScales([F)V
    .locals 0

    iput-object p1, p0, Lcom/google/android/libraries/barhopper/MultiScaleDetectionOptions;->extraScales:[F

    return-void
.end method
