.class public final Lcom/google/photos/vision/barhopper/zzac;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;
.source "com.google.mlkit:barcode-scanning@@17.3.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfn;


# static fields
.field private static final zzb:Lcom/google/photos/vision/barhopper/zzac;


# instance fields
.field private zzd:I

.field private zze:I

.field private zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/google/photos/vision/barhopper/zzac;

    invoke-direct {v0}, Lcom/google/photos/vision/barhopper/zzac;-><init>()V

    sput-object v0, Lcom/google/photos/vision/barhopper/zzac;->zzb:Lcom/google/photos/vision/barhopper/zzac;

    .line 2
    const-class v1, Lcom/google/photos/vision/barhopper/zzac;

    invoke-static {v1, v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;->zzV(Ljava/lang/Class;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;)V

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;-><init>()V

    .line 2
    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;

    iput-object v0, p0, Lcom/google/photos/vision/barhopper/zzac;->zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;

    return-void
.end method

.method static synthetic zza()Lcom/google/photos/vision/barhopper/zzac;
    .locals 1

    sget-object v0, Lcom/google/photos/vision/barhopper/zzac;->zzb:Lcom/google/photos/vision/barhopper/zzac;

    return-object v0
.end method


# virtual methods
.method protected final zzg(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 2
    add-int/lit8 p1, p1, -0x1

    const/4 p2, 0x0

    packed-switch p1, :pswitch_data_0

    :pswitch_0
    return-object p2

    .line 1
    :pswitch_1
    sget-object p1, Lcom/google/photos/vision/barhopper/zzac;->zzb:Lcom/google/photos/vision/barhopper/zzac;

    return-object p1

    :pswitch_2
    new-instance p1, Lcom/google/photos/vision/barhopper/zzab;

    .line 3
    invoke-direct {p1, p2}, Lcom/google/photos/vision/barhopper/zzab;-><init>(Lcom/google/photos/vision/barhopper/zza;)V

    return-object p1

    :pswitch_3
    new-instance p1, Lcom/google/photos/vision/barhopper/zzac;

    .line 4
    invoke-direct {p1}, Lcom/google/photos/vision/barhopper/zzac;-><init>()V

    return-object p1

    .line 2
    :pswitch_4
    const-string p1, "zze"

    const-string p2, "zzf"

    const-string p3, "zzd"

    filled-new-array {p3, p1, p2}, [Ljava/lang/Object;

    move-result-object p1

    sget-object p2, Lcom/google/photos/vision/barhopper/zzac;->zzb:Lcom/google/photos/vision/barhopper/zzac;

    const-string p3, "\u0004\u0002\u0000\u0001\u0001\u0002\u0002\u0000\u0000\u0000\u0001\u1004\u0000\u0002\u100a\u0001"

    invoke-static {p2, p3, p1}, Lcom/google/photos/vision/barhopper/zzac;->zzS(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfm;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1

    .line 1
    :pswitch_5
    const/4 p1, 0x1

    invoke-static {p1}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object p1

    return-object p1

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
