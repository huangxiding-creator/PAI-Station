.class public final Lcom/google/android/gms/internal/mlkit_common/zzsk;
.super Ljava/lang/Object;
.source "com.google.mlkit:common@@18.11.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_common/zzry;


# instance fields
.field private final zza:Lcom/google/android/gms/internal/mlkit_common/zzmw;

.field private zzb:Lcom/google/android/gms/internal/mlkit_common/zzqt;


# direct methods
.method private constructor <init>(Lcom/google/android/gms/internal/mlkit_common/zzmw;I)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance p2, Lcom/google/android/gms/internal/mlkit_common/zzqt;

    invoke-direct {p2}, Lcom/google/android/gms/internal/mlkit_common/zzqt;-><init>()V

    iput-object p2, p0, Lcom/google/android/gms/internal/mlkit_common/zzsk;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzqt;

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzsk;->zza:Lcom/google/android/gms/internal/mlkit_common/zzmw;

    invoke-static {}, Lcom/google/android/gms/internal/mlkit_common/zzsv;->zza()Lcom/google/android/gms/internal/mlkit_common/zzsv;

    return-void
.end method

.method public static zzf(Lcom/google/android/gms/internal/mlkit_common/zzmw;)Lcom/google/android/gms/internal/mlkit_common/zzry;
    .locals 2

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzsk;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/google/android/gms/internal/mlkit_common/zzsk;-><init>(Lcom/google/android/gms/internal/mlkit_common/zzmw;I)V

    return-object v0
.end method

.method public static zzg()Lcom/google/android/gms/internal/mlkit_common/zzry;
    .locals 3

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzsk;

    new-instance v1, Lcom/google/android/gms/internal/mlkit_common/zzmw;

    invoke-direct {v1}, Lcom/google/android/gms/internal/mlkit_common/zzmw;-><init>()V

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/google/android/gms/internal/mlkit_common/zzsk;-><init>(Lcom/google/android/gms/internal/mlkit_common/zzmw;I)V

    return-object v0
.end method


# virtual methods
.method public final zza(Lcom/google/android/gms/internal/mlkit_common/zzmv;)Lcom/google/android/gms/internal/mlkit_common/zzry;
    .locals 1

    .line 1
    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzsk;->zza:Lcom/google/android/gms/internal/mlkit_common/zzmw;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/mlkit_common/zzmw;->zzf(Lcom/google/android/gms/internal/mlkit_common/zzmv;)Lcom/google/android/gms/internal/mlkit_common/zzmw;

    return-object p0
.end method

.method public final zzb(Lcom/google/android/gms/internal/mlkit_common/zznc;)Lcom/google/android/gms/internal/mlkit_common/zzry;
    .locals 1

    .line 1
    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzsk;->zza:Lcom/google/android/gms/internal/mlkit_common/zzmw;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/mlkit_common/zzmw;->zzi(Lcom/google/android/gms/internal/mlkit_common/zznc;)Lcom/google/android/gms/internal/mlkit_common/zzmw;

    return-object p0
.end method

.method public final zzc(Lcom/google/android/gms/internal/mlkit_common/zzqt;)Lcom/google/android/gms/internal/mlkit_common/zzry;
    .locals 0

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzsk;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzqt;

    return-object p0
.end method

.method public final zzd()Ljava/lang/String;
    .locals 2

    .line 1
    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzsk;->zza:Lcom/google/android/gms/internal/mlkit_common/zzmw;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_common/zzmw;->zzk()Lcom/google/android/gms/internal/mlkit_common/zzmy;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_common/zzmy;->zzf()Lcom/google/android/gms/internal/mlkit_common/zzqv;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_common/zzqv;->zzk()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_common/zzqv;->zzk()Ljava/lang/String;

    move-result-object v0

    .line 2
    invoke-static {v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0

    .line 1
    :cond_1
    :goto_0
    const-string v0, "NA"

    return-object v0
.end method

.method public final zze(IZ)[B
    .locals 3

    .line 1
    xor-int/lit8 p2, p1, 0x1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzsk;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzqt;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eq v2, p2, :cond_0

    move p2, v1

    goto :goto_0

    .line 10
    :cond_0
    move p2, v2

    .line 1
    :goto_0
    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p2

    invoke-virtual {v0, p2}, Lcom/google/android/gms/internal/mlkit_common/zzqt;->zzf(Ljava/lang/Boolean;)Lcom/google/android/gms/internal/mlkit_common/zzqt;

    iget-object p2, p0, Lcom/google/android/gms/internal/mlkit_common/zzsk;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzqt;

    .line 2
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {p2, v0}, Lcom/google/android/gms/internal/mlkit_common/zzqt;->zze(Ljava/lang/Boolean;)Lcom/google/android/gms/internal/mlkit_common/zzqt;

    iget-object p2, p0, Lcom/google/android/gms/internal/mlkit_common/zzsk;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzqt;

    .line 3
    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_common/zzqt;->zzm()Lcom/google/android/gms/internal/mlkit_common/zzqv;

    move-result-object p2

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzsk;->zza:Lcom/google/android/gms/internal/mlkit_common/zzmw;

    invoke-virtual {v0, p2}, Lcom/google/android/gms/internal/mlkit_common/zzmw;->zzj(Lcom/google/android/gms/internal/mlkit_common/zzqv;)Lcom/google/android/gms/internal/mlkit_common/zzmw;

    .line 4
    :try_start_0
    invoke-static {}, Lcom/google/android/gms/internal/mlkit_common/zzsv;->zza()Lcom/google/android/gms/internal/mlkit_common/zzsv;

    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzsk;->zza:Lcom/google/android/gms/internal/mlkit_common/zzmw;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_common/zzmw;->zzk()Lcom/google/android/gms/internal/mlkit_common/zzmy;

    move-result-object p1

    .line 5
    new-instance p2, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;

    invoke-direct {p2}, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;-><init>()V

    sget-object v0, Lcom/google/android/gms/internal/mlkit_common/zzkr;->zza:Lcom/google/firebase/encoders/config/Configurator;

    invoke-virtual {p2, v0}, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;->configureWith(Lcom/google/firebase/encoders/config/Configurator;)Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;

    move-result-object p2

    invoke-virtual {p2, v2}, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;->ignoreNullValues(Z)Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;

    move-result-object p2

    invoke-virtual {p2}, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;->build()Lcom/google/firebase/encoders/DataEncoder;

    move-result-object p2

    invoke-interface {p2, p1}, Lcom/google/firebase/encoders/DataEncoder;->encode(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "utf-8"

    .line 6
    invoke-virtual {p1, p2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p1

    return-object p1

    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzsk;->zza:Lcom/google/android/gms/internal/mlkit_common/zzmw;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_common/zzmw;->zzk()Lcom/google/android/gms/internal/mlkit_common/zzmy;

    move-result-object p1

    .line 7
    new-instance p2, Lcom/google/android/gms/internal/mlkit_common/zzbg;

    invoke-direct {p2}, Lcom/google/android/gms/internal/mlkit_common/zzbg;-><init>()V

    .line 8
    sget-object v0, Lcom/google/android/gms/internal/mlkit_common/zzkr;->zza:Lcom/google/firebase/encoders/config/Configurator;

    .line 9
    invoke-interface {v0, p2}, Lcom/google/firebase/encoders/config/Configurator;->configure(Lcom/google/firebase/encoders/config/EncoderConfig;)V

    .line 8
    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_common/zzbg;->zza()Lcom/google/android/gms/internal/mlkit_common/zzbh;

    move-result-object p2

    invoke-virtual {p2, p1}, Lcom/google/android/gms/internal/mlkit_common/zzbh;->zza(Ljava/lang/Object;)[B

    move-result-object p1
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    new-instance p2, Ljava/lang/UnsupportedOperationException;

    .line 10
    const-string v0, "Failed to covert logging to UTF-8 byte array"

    invoke-direct {p2, v0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw p2
.end method
