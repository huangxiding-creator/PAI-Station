.class public final Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;
.super Ljava/lang/Object;
.source "com.google.mlkit:barcode-scanning@@17.3.0"


# instance fields
.field private extraScales:[F

.field private minimumDetectedDimension:I

.field private skipProcessingIfBarcodeFound:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    new-array v0, v0, [F

    iput-object v0, p0, Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;->extraScales:[F

    const/16 v0, 0xa

    iput v0, p0, Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;->minimumDetectedDimension:I

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;->skipProcessingIfBarcodeFound:Z

    return-void
.end method


# virtual methods
.method public getExtraScales()[F
    .locals 1

    iget-object v0, p0, Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;->extraScales:[F

    return-object v0
.end method

.method public getMinimumDetectedDimension()I
    .locals 1

    iget v0, p0, Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;->minimumDetectedDimension:I

    return v0
.end method

.method public getSkipProcessingIfBarcodeFound()Z
    .locals 1

    iget-boolean v0, p0, Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;->skipProcessingIfBarcodeFound:Z

    return v0
.end method

.method public setExtraScales([F)V
    .locals 0

    iput-object p1, p0, Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;->extraScales:[F

    return-void
.end method

.method public setMinimumDetectedDimension(I)V
    .locals 0

    iput p1, p0, Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;->minimumDetectedDimension:I

    return-void
.end method

.method public setSkipProcessingIfBarcodeFound(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;->skipProcessingIfBarcodeFound:Z

    return-void
.end method
