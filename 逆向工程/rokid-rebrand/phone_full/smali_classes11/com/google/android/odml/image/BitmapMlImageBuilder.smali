.class public Lcom/google/android/odml/image/BitmapMlImageBuilder;
.super Ljava/lang/Object;
.source "com.google.android.odml:image@@1.0.0-beta1"


# instance fields
.field private final zza:Landroid/graphics/Bitmap;

.field private zzb:I

.field private zzc:Landroid/graphics/Rect;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/net/Uri;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "uri"    # Landroid/net/Uri;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1
    .end local p0    # "this":Lcom/google/android/odml/image/BitmapMlImageBuilder;
    .end local p1    # "context":Landroid/content/Context;
    .end local p2    # "uri":Landroid/net/Uri;
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    invoke-static {p1, p2}, Landroid/provider/MediaStore$Images$Media;->getBitmap(Landroid/content/ContentResolver;Landroid/net/Uri;)Landroid/graphics/Bitmap;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/google/android/odml/image/BitmapMlImageBuilder;-><init>(Landroid/graphics/Bitmap;)V

    return-void
.end method

.method public constructor <init>(Landroid/graphics/Bitmap;)V
    .locals 3
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;

    .end local p0    # "this":Lcom/google/android/odml/image/BitmapMlImageBuilder;
    .end local p1    # "bitmap":Landroid/graphics/Bitmap;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/android/odml/image/BitmapMlImageBuilder;->zza:Landroid/graphics/Bitmap;

    const/4 v0, 0x0

    iput v0, p0, Lcom/google/android/odml/image/BitmapMlImageBuilder;->zzb:I

    new-instance v1, Landroid/graphics/Rect;

    .line 2
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v2

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p1

    invoke-direct {v1, v0, v0, v2, p1}, Landroid/graphics/Rect;-><init>(IIII)V

    iput-object v1, p0, Lcom/google/android/odml/image/BitmapMlImageBuilder;->zzc:Landroid/graphics/Rect;

    return-void
.end method


# virtual methods
.method public build()Lcom/google/android/odml/image/MlImage;
    .locals 9

    new-instance v8, Lcom/google/android/odml/image/MlImage;

    .end local p0    # "this":Lcom/google/android/odml/image/BitmapMlImageBuilder;
    new-instance v1, Lcom/google/android/odml/image/zze;

    iget-object v0, p0, Lcom/google/android/odml/image/BitmapMlImageBuilder;->zza:Landroid/graphics/Bitmap;

    .line 1
    invoke-direct {v1, v0}, Lcom/google/android/odml/image/zze;-><init>(Landroid/graphics/Bitmap;)V

    iget v2, p0, Lcom/google/android/odml/image/BitmapMlImageBuilder;->zzb:I

    iget-object v3, p0, Lcom/google/android/odml/image/BitmapMlImageBuilder;->zzc:Landroid/graphics/Rect;

    iget-object v0, p0, Lcom/google/android/odml/image/BitmapMlImageBuilder;->zza:Landroid/graphics/Bitmap;

    .line 2
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v6

    iget-object v0, p0, Lcom/google/android/odml/image/BitmapMlImageBuilder;->zza:Landroid/graphics/Bitmap;

    .line 3
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v7

    const-wide/16 v4, 0x0

    move-object v0, v8

    invoke-direct/range {v0 .. v7}, Lcom/google/android/odml/image/MlImage;-><init>(Lcom/google/android/odml/image/zzg;ILandroid/graphics/Rect;JII)V

    return-object v8
.end method

.method public setRotation(I)Lcom/google/android/odml/image/BitmapMlImageBuilder;
    .locals 0
    .param p1, "rotation"    # I

    .line 1
    .end local p0    # "this":Lcom/google/android/odml/image/BitmapMlImageBuilder;
    .end local p1    # "rotation":I
    invoke-static {p1}, Lcom/google/android/odml/image/MlImage;->zzc(I)V

    iput p1, p0, Lcom/google/android/odml/image/BitmapMlImageBuilder;->zzb:I

    return-object p0
.end method
