.class final Lcom/google/android/odml/image/zzc;
.super Lcom/google/android/odml/image/ImageProperties;
.source "com.google.android.odml:image@@1.0.0-beta1"


# instance fields
.field private final zza:I

.field private final zzb:I


# direct methods
.method synthetic constructor <init>(IILcom/google/android/odml/image/zza;)V
    .locals 0

    invoke-direct {p0}, Lcom/google/android/odml/image/ImageProperties;-><init>()V

    iput p1, p0, Lcom/google/android/odml/image/zzc;->zza:I

    iput p2, p0, Lcom/google/android/odml/image/zzc;->zzb:I

    return-void
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    .line 1
    :cond_0
    instance-of v1, p1, Lcom/google/android/odml/image/ImageProperties;

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    .line 2
    check-cast p1, Lcom/google/android/odml/image/ImageProperties;

    iget v1, p0, Lcom/google/android/odml/image/zzc;->zza:I

    .line 3
    invoke-virtual {p1}, Lcom/google/android/odml/image/ImageProperties;->getImageFormat()I

    move-result v3

    if-ne v1, v3, :cond_1

    iget v1, p0, Lcom/google/android/odml/image/zzc;->zzb:I

    .line 4
    invoke-virtual {p1}, Lcom/google/android/odml/image/ImageProperties;->getStorageType()I

    move-result p1

    if-ne v1, p1, :cond_1

    return v0

    :cond_1
    return v2
.end method

.method public final getImageFormat()I
    .locals 1

    iget v0, p0, Lcom/google/android/odml/image/zzc;->zza:I

    return v0
.end method

.method public final getStorageType()I
    .locals 1

    iget v0, p0, Lcom/google/android/odml/image/zzc;->zzb:I

    return v0
.end method

.method public final hashCode()I
    .locals 2

    iget v0, p0, Lcom/google/android/odml/image/zzc;->zza:I

    const v1, 0xf4243

    xor-int/2addr v0, v1

    mul-int/2addr v0, v1

    iget v1, p0, Lcom/google/android/odml/image/zzc;->zzb:I

    xor-int/2addr v0, v1

    return v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 4

    iget v0, p0, Lcom/google/android/odml/image/zzc;->zza:I

    iget v1, p0, Lcom/google/android/odml/image/zzc;->zzb:I

    new-instance v2, Ljava/lang/StringBuilder;

    .line 1
    const/16 v3, 0x41

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v3, "ImageProperties{imageFormat="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, ", storageType="

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, "}"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
