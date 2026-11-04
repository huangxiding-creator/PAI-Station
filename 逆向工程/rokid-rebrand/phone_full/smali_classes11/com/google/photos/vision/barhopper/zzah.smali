.class public final Lcom/google/photos/vision/barhopper/zzah;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;
.source "com.google.mlkit:barcode-scanning@@17.3.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfn;


# static fields
.field private static final zzb:Lcom/google/photos/vision/barhopper/zzah;


# instance fields
.field private zzd:I

.field private zze:Ljava/lang/String;

.field private zzf:Ljava/lang/String;

.field private zzg:B


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/google/photos/vision/barhopper/zzah;

    invoke-direct {v0}, Lcom/google/photos/vision/barhopper/zzah;-><init>()V

    sput-object v0, Lcom/google/photos/vision/barhopper/zzah;->zzb:Lcom/google/photos/vision/barhopper/zzah;

    const-class v1, Lcom/google/photos/vision/barhopper/zzah;

    invoke-static {v1, v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;->zzV(Ljava/lang/Class;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;)V

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;-><init>()V

    const/4 v0, 0x2

    iput-byte v0, p0, Lcom/google/photos/vision/barhopper/zzah;->zzg:B

    const-string v0, ""

    iput-object v0, p0, Lcom/google/photos/vision/barhopper/zzah;->zze:Ljava/lang/String;

    iput-object v0, p0, Lcom/google/photos/vision/barhopper/zzah;->zzf:Ljava/lang/String;

    return-void
.end method

.method static synthetic zza()Lcom/google/photos/vision/barhopper/zzah;
    .locals 1

    sget-object v0, Lcom/google/photos/vision/barhopper/zzah;->zzb:Lcom/google/photos/vision/barhopper/zzah;

    return-object v0
.end method

.method public static zzb()Lcom/google/photos/vision/barhopper/zzah;
    .locals 1

    sget-object v0, Lcom/google/photos/vision/barhopper/zzah;->zzb:Lcom/google/photos/vision/barhopper/zzah;

    return-object v0
.end method


# virtual methods
.method public final zzc()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzah;->zze:Ljava/lang/String;

    return-object v0
.end method

.method public final zzd()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/google/photos/vision/barhopper/zzah;->zzf:Ljava/lang/String;

    return-object v0
.end method

.method protected final zzg(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 2
    add-int/lit8 p1, p1, -0x1

    const/4 p3, 0x0

    packed-switch p1, :pswitch_data_0

    :pswitch_0
    if-nez p2, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    .line 1
    :pswitch_1
    sget-object p1, Lcom/google/photos/vision/barhopper/zzah;->zzb:Lcom/google/photos/vision/barhopper/zzah;

    return-object p1

    :pswitch_2
    new-instance p1, Lcom/google/photos/vision/barhopper/zzag;

    .line 3
    invoke-direct {p1, p3}, Lcom/google/photos/vision/barhopper/zzag;-><init>(Lcom/google/photos/vision/barhopper/zza;)V

    return-object p1

    :pswitch_3
    new-instance p1, Lcom/google/photos/vision/barhopper/zzah;

    invoke-direct {p1}, Lcom/google/photos/vision/barhopper/zzah;-><init>()V

    return-object p1

    .line 2
    :pswitch_4
    const-string p1, "zze"

    const-string p2, "zzf"

    const-string p3, "zzd"

    filled-new-array {p3, p1, p2}, [Ljava/lang/Object;

    move-result-object p1

    sget-object p2, Lcom/google/photos/vision/barhopper/zzah;->zzb:Lcom/google/photos/vision/barhopper/zzah;

    const-string p3, "\u0004\u0002\u0000\u0001\u0001\u0002\u0002\u0000\u0000\u0001\u0001\u1008\u0000\u0002\u1508\u0001"

    invoke-static {p2, p3, p1}, Lcom/google/photos/vision/barhopper/zzah;->zzS(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfm;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1

    :pswitch_5
    iget-byte p1, p0, Lcom/google/photos/vision/barhopper/zzah;->zzg:B

    .line 1
    invoke-static {p1}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object p1

    return-object p1

    .line 2
    :cond_0
    const/4 p1, 0x1

    :goto_0
    iput-byte p1, p0, Lcom/google/photos/vision/barhopper/zzah;->zzg:B

    return-object p3

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method
