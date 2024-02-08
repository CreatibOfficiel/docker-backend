<?php

namespace App\Controller;

use App\Repository\ArticleRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class ArticleController extends AbstractController
{
    public function __construct(
        private ArticleRepository $articleRepo,
    ) {
    }

    #[Route('/article', name: 'app_article')]
    public function index(): Response
    {
        $articles = $this->articleRepo->findAll();

        return $this->render('article/index.html.twig', [
            'articles' => $articles,
        ]);
    }
}
